//
//  ViewController.swift
//  PaymentScreenTask
//
//  Created by Gerild Pjetri on 15.11.20.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{

    
    
    
    
    @IBOutlet weak var topSectionPickerView: UIPickerView!
    
    @IBOutlet weak var topSectionBalance: UITextField!
    
    @IBOutlet weak var balanceButtonTopSection: UIButton!
    
    @IBOutlet weak var tableViewNameAndAddress: UITableView!
    
    
    @IBOutlet weak var destination: UITextField!
    
    
    @IBOutlet weak var amount: UITextField!
    
    
    
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var currencySelectedField: UITextField!
    
    
    var addressBookSampleData : [AddressBook] = []
    
    var currencyArray : [String] = ["$","€","¥","£"]
    var pickedCurrencyTop :String = ""
    var pickedCurrencyBottom :String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencySelectedField.text = "$"
        topSectionBalance.text = "1000"
        
        let nib = UINib.init(nibName: "CustomTableViewCell", bundle: nil)
        self.tableViewNameAndAddress.register(nib, forCellReuseIdentifier: "CustomCell")

        self.tableViewNameAndAddress.rowHeight = 60
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
   
   
        scrollView.addGestureRecognizer(tap)
        
        amount.keyboardType = .numberPad
        
        //amount.delegate = self
        
        //amount.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        
            
        let itemAddressBook = AddressBook()
        itemAddressBook.name = "John"
        itemAddressBook.address = "Street 14 , London"
        
        
        let itemAddressBook1 = AddressBook()
        itemAddressBook1.name = "Klaus"
        itemAddressBook1.address = "Street 34553 , Munchen"
        
        
        let itemAddressBook2 = AddressBook()
        itemAddressBook2.name = "Akihiro"
        itemAddressBook2.address = "Street 7488 , Tokyo"
        
        
        let itemAddressBook3 = AddressBook()
        itemAddressBook3.name = "Karlo"
        itemAddressBook3.address = "Street 4778 , Roma"
        
        let itemAddressBook4 = AddressBook()
        itemAddressBook4.name = "Aeolus"
        itemAddressBook4.address = "Street 4778 , Athens"
            
        
        
        addressBookSampleData.append(itemAddressBook)
        addressBookSampleData.append(itemAddressBook1)
        addressBookSampleData.append(itemAddressBook2)
        addressBookSampleData.append(itemAddressBook3)
//        addressBookSampleData.append(itemAddressBook4)
        
      
        
        topSectionPickerView.delegate = self
        topSectionPickerView.dataSource = self
        
        
        
        tableViewNameAndAddress.delegate = self
        tableViewNameAndAddress.dataSource = self
        
        tableViewNameAndAddress.reloadData()
        
        
//        let formatter = NumberFormatter()
//        formatter.usesGroupingSeparator = true
//        formatter.maximumFractionDigits = 2
//        formatter.minimumFractionDigits = 2
//        formatter.numberStyle = .decimal
//        //formatter.locale = Locale.current
//
//        
//        formatter.locale = Locale(identifier: "en_US")
//
//
//        let value = 1000
//
//        if let formattedString = formatter.string(for:value) {
//            topSectionBalance.text = formattedString
//        }
        
        
        
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else {return}
        
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        
        let keyboardFrame = keyboardSize.cgRectValue
        
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y -= keyboardFrame.height
        }
        
    }
    
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else {return}
        
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        
        let keyboardFrame = keyboardSize.cgRectValue
        
        if self.view.frame.origin.y != 0{
            
            self.view.frame.origin.y += keyboardFrame.height
        }
    }
    
    
    
    @objc func myTextFieldDidChange(_ textField: UITextField) {

        if let amountString = amount.text?.currencyInputFormatting() {

            amount.text =  amountString

        }

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {


        let currentText = textField.text ?? ""

        guard let stringRange = Range(range, in: currentText) else { return false }

        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        return updatedText.count <= 10


    }
    
    
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
        
    }
    
    @objc func closeKeyboard() {
        
        view.endEditing(true)
        
    }
    
   
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        
        
        return currencyArray[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
//        if pickerView == topSectionPickerView {
//
//            pickedCurrencyTop = currencyArray[row]
//
//
//        }else if pickerView == bottomSectionPickerView{
//
//
//            pickedCurrencyBottom = currencyArray[row]
//
//        }

        
        pickedCurrencyTop = currencyArray[row]
        
        currencySelectedField.text = pickedCurrencyTop
        
        if (pickedCurrencyTop == "$"){
            
            topSectionBalance.text = "1000"
            
        }else if(pickedCurrencyTop == "€"){
            
            topSectionBalance.text = "970"
            
        }else if(pickedCurrencyTop == "¥"){
            
            topSectionBalance.text = "2400"
            
        }else if(pickedCurrencyTop == "£"){
            
            topSectionBalance.text = "800"
            
        }
        
        
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
            
        return addressBookSampleData.count
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let Item = self.addressBookSampleData[indexPath.row]
        
        self.destination.text = Item.name!
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
        
    }
    
   
       
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        
        
       
        
        let Item = self.addressBookSampleData[indexPath.row]
        
        cell.name.text = Item.name!
        
        cell.address.text = Item.address!
            
        
        
        return(cell)
    }

    
    
    @IBAction func test(_ sender: Any) {
        
        
        tableViewNameAndAddress.reloadData()
        
        
    }
    

}










