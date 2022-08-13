//
//  OwnerHomeVC.swift
//  DogWalker

import UIKit
class OwnerHomeTVC: UITableViewCell {
   
    @IBOutlet weak var vwBack: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblExp: UILabel!
    @IBOutlet weak var btnStar: UIButton!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblAvailability: UILabel!
    
    func applyStyle(){
        self.vwBack.layer.cornerRadius = 8
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.applyStyle()
    }
    
    deinit {
        debugPrint("‼️‼️‼️ deinit : \(self) ‼️‼️‼️")
    }
    
    func configCell(data: UserWalkerModel){
        self.lblExp.text = data.experience.description + "Yrs"
        self.lblName.text = data.name.description
        self.lblHours.text = data.hourlyRate.description + "/Hr"
        self.lblAvailability.text = "Availability \(data.timing.description)"
        
        self.imgProfile.setImgWebUrl(url: data.profile, isIndicator: true)
    }
    
}

class OwnerHomeVC: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnVerifyWalker: UIButton!
    
    var array = [UserWalkerModel]()
    
    func setUpView(){
        self.tblView.delegate = self
        self.tblView.dataSource = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.btnVerifyWalker.layer.cornerRadius = self.btnVerifyWalker.bounds.height/2
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    deinit {
        debugPrint("‼️‼️‼️ deinit : \(self) ‼️‼️‼️")
    }

}

extension OwnerHomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OwnerHomeTVC") as! OwnerHomeTVC
        cell.configCell(data: self.array[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "WalkerDetailsVC") as? WalkerDetailsVC {
            nextVC.data = self.array[indexPath.row]
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    func getData(){
        AppDelegate.shared.database.collection(dDogWalker).whereField(dIsEnable, isEqualTo: true).addSnapshotListener{querySnapshot , error in
            
            guard let snapshot = querySnapshot else {
                print("Error")
                return
            }
            self.array.removeAll()
            if snapshot.documents.count != 0 {
                for data in snapshot.documents {
                    let data1 = data.data()
                    if let name: String = data1[dUser_name] as? String, let isEnable: Bool = data1[dIsEnable] as? Bool, let exp: String = data1[dExp] as? String, let email: String = data1[dUser_email] as? String, let password: String = data1[dPassword] as? String, let hourlyRate: String = data1[dUser_hourly_rate] as? String, let userType: String = data1[dType] as? String, let timing: String = data1[dTiming] as? String, let from: String = data1[dTimingFrom] as? String, let to: String = data1[dTimingTo] as? String, let description: String = data1[dUser_description] as? String, let lat: Double = data1[dLat] as? Double, let lng: Double = data1[dLng] as? Double, let profile: String = data1[dUser_image] as? String, let rating: Double = data1[dRating] as? Double, let reserved: Bool = data1[dIsReserved] as? Bool {
                        print("Data Count : \(self.array.count)")
                        self.array.append(UserWalkerModel(docID: data.documentID, name: name, experience: exp, email: email, password: password, hourlyRate: hourlyRate, userType: userType, timing: timing, from: from, to: to, isEnable: isEnable, description: description, lat: lat, lng: lng, profile: profile, rating: rating, reserved: reserved))
                    }
                    self.tblView.delegate = self
                    self.tblView.dataSource = self
                    self.tblView.reloadData()
                }
            }else{
                Alert.shared.showAlert(message: "No Data Found !!!", completion: nil)
            }
        }
    }
}
