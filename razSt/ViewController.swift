//
//  ViewController.swift
//  razSt
//
//  Created by Shubham Deshmukh on 28/12/23.
//

import UIKit
import Razorpay

class ViewController: UIViewController {

    let razorPayKey = "rzp_test_zDTi8rg3wfM7oK"
    var razorPay : RazorpayCheckout? = nil
    var merchantDetails: MerchantDetails = MerchantDetails.getDefaultDetails()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

   
    
    @IBAction func payTapped(_ sender: Any) {
        openRazorPayheckout()
    }
    
    func openRazorPayheckout() {
        razorPay = RazorpayCheckout.initWithKey(razorPayKey, andDelegate: self)
        let options: [String:Any] = [
                       "amount": "100", //This is in currency subunits. 100 = 100 paise= INR 1.
                       "currency": "INR",//We support more that 92 international currencies.
                       "description": "Pay 100 money",
//                       "order_id": "order_DBJOWzybf0sJbb",
                       "image": merchantDetails.logo,
                       "name":  merchantDetails.name,
                       "prefill": [
                           "contact": "8989734106",
                           "email": "shubhamdehmukh69@gmail.com"
                       ],
                       "theme": [
                           "color": "#F37254"
                       ]
                   ]
        razorPay?.open(options)
    }
}

extension ViewController : RazorpayPaymentCompletionProtocol {

    func onPaymentError(_ code: Int32, description str: String) {
        print("error: ", code, str)
        self.presentAlert(withTitle: "Alert", message: str)
    }

    func onPaymentSuccess(_ payment_id: String) {
        print("success: ", payment_id)
        self.presentAlert(withTitle: "Success", message: "Payment Succeeded")
    }
    
    func presentAlert(withTitle title: String?, message: String?){
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Okay", style: .default)
            alertController.addAction(okAction)
        }
    }
}

struct MerchantDetails {
    let name: String
    let logo: String
    let color: UIColor
}

extension MerchantDetails {
    static func getDefaultDetails() -> MerchantDetails {
        let details = MerchantDetails(name: "iOSPaymentGateway", logo: "https://www.google.com/search?q=razorpay+logo&sca_esv=594236971&rlz=1C5CHFA_enIN1032IN1032&tbm=isch&source=lnms&sa=X&ved=2ahUKEwj3rq24sLKDAxXNxjgGHZLJAcUQ_AUoAXoECAMQAw&biw=948&bih=993&dpr=1#imgrc=3uHoAkuhZgAaQM", color: .blue)
        return details
    }
}
