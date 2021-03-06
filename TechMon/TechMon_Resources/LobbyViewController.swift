//
//  LobbyViewController.swift
//  TechMon
//
//  Created by Maho Misumi on 2017/09/20.
//  Copyright © 2017年 Maho Misumi. All rights reserved.
//

import UIKit
//音声ファイルを使う準備
import AVFoundation

class LobbyViewController: UIViewController, AVAudioPlayerDelegate {

    var stamina: Float = 0
    var staminaTimer: Timer!
    var util: TechDraUtility!
    var player: Player!
    
    @IBOutlet var nameLabel: UILabel!  //名前表示のラベル
    @IBOutlet var staminaBar: UIProgressView! //スタミナ表示用ラベル
    @IBOutlet var levelLabel: UILabel! //レベル表示用ラベル
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //プレイヤーの設定
        
        player = Player(name: "勇者", imageName: "yusya.png")
        staminaBar.transform = CGAffineTransform(scaleX: 1.0, y: 4.0)
        
        nameLabel.text = player.name
        levelLabel.text = "Lv. 15"
        stamina = 100
        
        util = TechDraUtility()
        
        cureStamina()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool){
          super.viewWillAppear(true)
          util.playBGM(fileName: "lobby")
    }
    
    override func viewWillDisappear(_ animated: Bool){
        util.stopBGM()
    }
    
    @IBOutlet var backgroundImageView: UIImageView!

    @IBAction func toBattle(){
        
        //スタミナが50以上あればスタミナ50消費して戦闘画面へ
        if stamina >= 50 {
            
            stamina -= 50
            staminaBar.progress = stamina / 100
            self.performSegue(withIdentifier: "toBattle", sender: nil)
        } else {
            
            //スタミナが足りない時はアラートを出す
            let alert = UIAlertController(title: "バトルに行けません。", message: "スタミナを貯めてください。", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
        }
        }
    
    func cureStamina() {
        
        //3秒毎に１スタミナ回復させる
        staminaTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector (LobbyViewController.updateStaminaValue), userInfo: nil, repeats: true)
        staminaTimer.fire()
        
    }
    
    func updateStaminaValue() {
        
        if stamina <= 100{
            stamina += 1
            staminaBar.progress = stamina / 100
            
        
    }
    
    
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
