//
//  ViewController.swift
//  RealmPart2
//
//  Created by IwasakIYuta on 2021/07/15.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    func dialog(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.dismiss(animated: true)
            }
        }
    }
    //空文字をどうにかしたいおおおお
    @IBAction func createButton(_ sender: UIButton) {
        if  emailTextField.text!.isEmpty || emailTextField.text!.count < 0 || emailTextField.text!.contains(""){
            dialog(title: "未入力", message: "emailを登録してください")
            return
        }
        let users = try! Realm().objects(Users.self)//Users.selfを抽出して
        let predicate = NSPredicate(format: "email == %@", emailTextField.text!)
        if let email = users.filter(predicate).first{
            dialog(title: "登録", message: "\(email.email)は登録されています")
            return
        }
        let user = Users(email: emailTextField.text!)
        user.name = nameTextField.text!
        user.id = idTextField.text!
        user.age = Int16(ageTextField.text!) ?? 0
   
        do {
            let realm = try Realm()
            try realm.write({
                realm.add(user)
            })}
         catch {
            print(error)
        }
    }
    
    @IBAction func readButton(_ sender: UIButton) {
        let users = try! Realm().objects(Users.self)
        if users.isEmpty {
            print("no data")
        }
        print("Usersの全データです\(users)")
        for data in users {
            nameLabel.text = data.name
            idLabel.text = data.id
            ageLabel.text = String(data.age)
            emailLabel.text = data.email
            
        }

    
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        let users = try! Realm().objects(Users.self)//Users.selfを抽出して
        let predicate = NSPredicate(format: "email == %@", emailTextField.text!)//emailが一致したやつを指定
        if let userName = users.filter(predicate).first{
            nameLabel.text = userName.name
        
            print(userName)
        }
        else {
           dialog(title: "未登録", message: "ないよーー")
        }
     
        
    }
    
    @IBAction func upDateButton(_ sender: UIButton) {
        let users = try! Realm().objects(Users.self)//Users.selfを抽出して
        let predicate = NSPredicate(format: "email == %@", emailTextField.text!)//emailが一致したやつを指定
        if let user = users.filter(predicate).first {
           
            do {
                let realm = try Realm()
                try realm.write({
                    //値を変更するにはwrite内で行う必要がある
                    user.name = nameTextField.text!
                    user.age = Int16(ageTextField.text!)!
                    realm.add(user)
                })
                print(user)
            } catch {
                print(error)
            }

        
        } else {
            dialog(title: "そのemail未登録", message: "変更できませんでしたー")
         }
        
    
    
    


}
    @IBAction func deleteButton(_ sender: UIButton) {
        let users = try! Realm().objects(Users.self)//Users.selfを抽出して
        let predicate = NSPredicate(format: "email == %@", emailTextField.text!)//emailが一致したやつを指定
        if let user = users.filter(predicate).first {
           
            do {
                let realm = try Realm()
                try realm.write({
                    realm.delete(user)
                    dialog(title: "削除", message: "そのemailの登録情報は削除されました")
                })
                print(user)
            } catch {
                print(error)
            }

        
        } else {
            dialog(title: "削除", message: "そのemailは登録されていません")
         }
    
    }
    
    @IBAction func deleteAllButton(_ sender: UIButton) {
           
            do {
                let realm = try Realm()
                try realm.write({
                    realm.deleteAll()
                })
            } catch {
                print(error)
            }
            dialog(title: "全削除", message: "全ての登録情報は削除されました")
         }
    
    
    
}
