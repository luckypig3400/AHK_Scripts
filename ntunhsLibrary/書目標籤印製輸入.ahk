/*
OS: Windows10
Screen Resolution: 1920*1080
Scale and layout: 125%
Target Program: SirsiDynix Symphony WorkFlows
重要:目標視窗要最大化
*/

MsgBox 歡迎使用簡易自動化腳本來協助您完成要印製書標貼紙書籍條碼的點擊步驟!
MsgBox 請您把要查詢的書本條碼整理成bookList_stickers.txt`n放在與此腳本相同的目錄之下`n接著您可以透過鍵盤組合建Alt+E開始執行

;按鍵Alt+E開始執行
!E:: 

  ;讀取文字檔 https://www.autohotkey.com/boards/viewtopic.php?t=90919
  FileRead, FileContent, bookList_stickers.txt
  bookList := StrSplit(FileContent, "`r`n")
  
  i := 1
  ;在下方(數字3)更改本批清單中的書籍數量
  ;Loop, 3
  ;或是使用預設值(自動抓取清單中的書本數量)
  ; https://www.autohotkey.com/boards/viewtopic.php?t=31061
  bookCount := bookList.MaxIndex()
  MsgBox,, 書本清單數量, 本次清單共%bookCount%本書`n`n按下確定開始執行
  Loop, %bookCount%
  {
    clipboard := bookList[i]

    ;點選館藏條碼輸入框
    ClickPosition(513, 249, 1, 0, "Screen", true)
    Sleep 100

    ;鍵盤輸入滑鼠組合鍵
    ;https://www.autohotkey.com/boards/viewtopic.php?t=85456
    Send, ^a ; Ctrl + A
    Sleep 100
    Send, ^v ; Ctrl + V
    Sleep 100
    Send, {Enter}
    Sleep 100

    ;MsgBox %clipboard%

    i += 1
  }

  MsgBox 腳本順利執行完成!
return ;代表該區段腳本結束

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