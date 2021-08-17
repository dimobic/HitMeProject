import UIKit

class ViewController: UIViewController {

    var TargetValue: Int = 0
    var Score : Int = 0
    var Round: Int = 1
    
    lazy var LabelTarget : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var LabelScore : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var LabelRounds : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var HitMeButton: UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("HitMe", for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.backgroundColor = .black
        Button.tintColor = .white
        Button.layer.borderWidth = 1
        Button.layer.borderColor = UIColor.lightGray.cgColor
        Button.layer.cornerRadius = 20.0
        Button.addTarget(self, action: #selector(HitMeTouchUpInside), for: .touchUpInside)
        return Button
    }()
    lazy var InfoButton: UIButton = {
        let Button = UIButton(type: .system)
        Button.setImage(UIImage(named:"Info"), for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(InfoButtonTouchUpInside), for: .touchUpInside)
        return Button
    }()
    lazy var NewRoundButton: UIButton = {
        let Button = UIButton(type: .system)
        Button.setTitle("New Game", for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.backgroundColor = .black
        Button.tintColor = .white
        Button.layer.borderWidth = 1
        Button.layer.borderColor = UIColor.lightGray.cgColor
        Button.layer.cornerRadius = 20.0
        Button.addTarget(self, action: #selector(NewGameTouchUpInside), for: .touchUpInside)
        return Button
    }()
    lazy var Slider: UISlider = {
        let slid = UISlider()
        slid.translatesAutoresizingMaskIntoConstraints = false
        slid.maximumValue = 100
        slid.minimumValue = 0
        slid.setValue(50, animated: false)
        slid.setThumbImage(UIImage(named: "shot"), for: .normal)
        slid.setThumbImage(UIImage(named: "bigshot"), for: .highlighted)
        slid.setMinimumTrackImage(UIImage(named: "RUR"), for: .normal)
        //slid.setMaximumTrackImage(UIImage(named: "USD"), for: .normal)
        //slid.addTarget(self, action: #selector(sliderMoved), for: .valueChanged)
        return slid
    }()
    
    @IBAction func InfoButtonTouchUpInside(){
        let viewController = AboutViewController()
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.modalPresentationStyle = .fullScreen
        navigation.modalTransitionStyle = .flipHorizontal
        self.present(navigation, animated: true, completion: nil)
    }
    @IBAction func HitMeTouchUpInside(){
        let difference = abs(TargetValue - lroundf(Slider.value))
        var RoundScore = 100 - difference
        let title: String
          if difference == 0 {
            title = "Perfect!"
            RoundScore += 100
          } else if difference < 10 {
            title = "You almost had it!"
            RoundScore += 50
          } else if difference < 20 {
            title = "Pretty good!"
            RoundScore += 25
          } else {
            title = "Not even close..."
          }
        Score += RoundScore
        Round += 1
        let Alert = UIAlertController(title: title ,message: "The value of the slider is: \(lroundf(Slider.value)) \n Add to you scope:\(RoundScore)", preferredStyle: .alert)
        let AlertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.Change()
        }
        Alert.addAction(AlertAction)
        present(Alert, animated: true, completion:  nil)
    }
    @IBAction func NewGameTouchUpInside(){
        let Alert = UIAlertController(title: "You started a new game",message: "You score is: \(Score) \n Good Luck!", preferredStyle: .alert)
        let AlertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.Score = 0
            self.Slider.setValue(50, animated: true)
            self.Round = 1
            self.Change()
            let transition = CATransition()
            transition.type = CATransitionType.fade
            transition.duration = 1
            transition.timingFunction = CAMediaTimingFunction( name: CAMediaTimingFunctionName.easeOut)
            self.view.layer.add(transition, forKey: nil)
        }
        Alert.addAction(AlertAction)
        present(Alert, animated: true, completion:  nil)
    }
    func Change(){
        TargetValue = Int.random(in: 0...100)
        LabelTarget.text = "Set the slider value to: \(String(TargetValue))"
        LabelScore.text = "You Score: \(String(Score))"
        LabelRounds.text = "Round: \(Round)"
    }
    func addSubviews() {
        self.view.addSubview(HitMeButton)
        self.view.addSubview(Slider)
        self.view.addSubview(LabelTarget)
        self.view.addSubview(LabelScore)
        self.view.addSubview(NewRoundButton)
        self.view.addSubview(LabelRounds)
        self.view.addSubview(InfoButton)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        addSubviews()
        setupConstraints()
        Change()
    }
    
    func setupConstraints() {
        HitMeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50).isActive = true
        HitMeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        HitMeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        HitMeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        Slider.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
        Slider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Slider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4).isActive = true
        Slider.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        LabelTarget.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150).isActive = true
        LabelTarget.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        LabelTarget.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        LabelScore.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        LabelScore.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20).isActive = true
        LabelScore.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        NewRoundButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        NewRoundButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        NewRoundButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/4).isActive = true
        NewRoundButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        LabelRounds.bottomAnchor.constraint(equalTo: LabelScore.topAnchor, constant: -20).isActive = true
        LabelRounds.leftAnchor.constraint(equalTo: view.leftAnchor ,constant: 20).isActive = true
        LabelRounds.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        InfoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        InfoButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    }
    
}



/*lazy var avatar: UIImageView = {
     let imageView = UIImageView(image: UIImage(named: "DSC04450.jpg"))
     //imageView.autoSetDimensions(to: CGSize(width: 128.0, height: 160.0))
     imageView.layer.borderWidth = 13.0
     imageView.layer.borderColor = UIColor.lightGray.cgColor
     imageView.layer.cornerRadius = 15.0
     imageView.clipsToBounds = true
     return imageView
 }()
 
 lazy var upperView: UIView = {
     let view = UIView()
     //view.autoSetDimension(.height, toSize: 128)
     view.backgroundColor = .gray
     return view
 }()
         nameTextField = UITextField(frame: .zero)
         nameTextField.placeholder = "Login Name"
         nameTextField.borderStyle = .roundedRect
         nameTextField.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(nameTextField)

     avatar  = UIImageView(frame:CGRectMake(10, 50, 100, 300));
     avatar.image = UIImage(named:"DSC04450.jpg")
             self.view.addSubview(avatar)
         constraintsInit()
       }

 */
