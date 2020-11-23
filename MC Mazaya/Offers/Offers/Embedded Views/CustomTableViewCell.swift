
import UIKit

class CustomTableViewCell: UITableViewCell {
    
    //Offers
    @IBOutlet var nameLabel:UILabel!
    @IBOutlet var addressLabel:UILabel!
    @IBOutlet var servicetype : UILabel!
    
  //  @IBOutlet var selectedOFfer : UIButton!
    @IBOutlet var selectedrow :UIImageView?
    
    
   // @IBOutlet weak var UseAnoffer: UIButton!
    
    //Branch
    @IBOutlet var Bname :UILabel!
    @IBOutlet var BDescriprion :UILabel!
    @IBOutlet var BMapLocation :UIButton!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func onClickedButton(_ sender:UIButton) {
           
         
           
          print("HI AJwan")
       }
}
