/*
OS: Windows10
Screen Resolution: 1920*1080
Scale and layout: 125%
Target Program: SirsiDynix Symphony WorkFlows
重要:目標視窗要最大化
*/

MsgBox 歡迎使用簡易自動化腳本來協助您完成建議權威檔案的點擊步驟!
MsgBox 您可以參考以下使用說明: Alt+E開始執行

;按鍵Alt+E開始執行
!E:: 
  ;YesNo對話框 https://www.autohotkey.com/docs/v1/lib/MsgBox.htm
  MsgBox, 4,, 此書是否為專業書籍?`n(點選是會自動填入f，反之歸為一般書籍g)
  ;IfMsgBox執行多行指令 https://www.autohotkey.com/boards/viewtopic.php?t=74473
  IfMsgBox Yes
  classifyBookASprofessional()
  else
    classifyBookASgeneral()
  Sleep, 100

  ;點檢查權威的綠色勾勾
  ClickPosition(290, 172, 1, 0, "Screen", true)
  Sleep 600

  While(!ClickPicture("images/finishedCheck.png", 1, 0,true,false))
  {
    ;點建議
    ClickPosition(1842, 429, 1, 0, "Screen", true)
    Sleep 600

    ;點OK
    ClickPosition(1054, 1001, 1, 0, "Screen", true)
    Sleep 300

    ;點下一頁
    ClickPosition(1842, 211, 1, 0, "Screen", true)
    Sleep 300
  }

  ;點完成檢驗的OK(有新增權威跳出的大框)
  ClickPosition(1082, 669, 1, 0, "Screen", true)
  Sleep 300

  ;點完成檢驗的OK(小框)
  ClickPosition(1082, 636, 1, 0, "Screen", true)
  Sleep 300

  ;點索書號/館藏
  ClickPosition(550, 260, 1, 0, "Screen", true)
  Sleep 100

  ;點存儲
  ClickPosition(990, 990, 1, 0, "Screen", true)
  Sleep 100

  ;滑鼠移至返回檢索
  MouseMove, 900, 990

return ;代表該區段腳本結束

;按鍵Alt+G開始執行
!G::
  classifyBookASgeneral()
return ;代表該區段腳本結束

classifyBookASgeneral(){
  ;點讀者對象輸入框，讀者對象填入g(一般書籍)
  ClickPosition(1835, 416, 1, 0, "Screen", true)
  Sleep 100
  Send g
}

;按鍵Alt+F開始執行，讀者對象填入f(專業書籍)
!F::
  classifyBookASprofessional()
return ;代表該區段腳本結束

classifyBookASprofessional(){
  ;點讀者對象輸入框
  ClickPosition(1835, 416, 1, 0, "Screen", true)
  Sleep 100
  Send f
}

;獲取圖片的位置
GetPicturePosition(ImageFilePath){
  gui,add,picture,hwndmypic,%ImageFilePath%
  controlgetpos,,,width,height,,ahk_id %mypic%
  CoordMode Pixel
  ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight,%ImageFilePath%
  CoordMode Mouse
  if %FoundX%{
    return [FoundX+width/2,FoundY+height/2]
  } else {
    return FoundX
  }
}

;模擬滑鼠點擊圖片
ClickPicture(ImageFilePath,ClickCount:=1,Speed:=0,Return:=true,ShowError:=true){
  pos:=GetPicturePosition(ImageFilePath)
  if %pos%{
    posX:=pos[1]
    posY:=pos[2]
    ClickPosition(posX,posY,ClickCount,Speed,,Return)
    return [posX,posY]
  }else{
    if %ShowError% {
      MSGBOX 畫面中找不到圖片`n %ImageFilePath%
    }
    return false
  }
}

;模擬滑鼠點擊
ClickPosition(posX,posY,ClickCount:=1,Speed:=0,CoordMode:="Screen",Return:=true){
  ;若使用相對模式
  if (CoordMode="Relative"){
    CoordMode,Mouse,Screen
    MouseGetPos, posX_i, posY_i ;儲存原來的滑鼠位置
    ;根據點擊次數是否為零來使用MouseClick或MouseMove
    if %ClickCount%{
      MouseClick,,%posX%,%posY%,%ClickCount%,%Speed%,,R ;點擊相對位置
    }else{
      MouseMove, %posX%, %posY%,%Speed%
    }
    ;若使用其他模式
  }else{
    CoordMode,Mouse,%CoordMode%
    MouseGetPos, posX_i, posY_i ;儲存原來的滑鼠位置
    ;根據點擊次數是否為零來使用MouseClick或MouseMove
    if %ClickCount%{
      MouseClick,,%posX%,%posY%,%ClickCount%,%Speed%
    }else{
      MouseMove, %posX%, %posY%,%Speed%
    }
  }
  ;是否點擊後返回
if %Return%{
  MouseMove, %posX_i%, %posY_i%,%Speed%
}
return
}