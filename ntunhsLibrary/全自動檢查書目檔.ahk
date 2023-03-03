/*
OS: Windows10
Screen Resolution: 1920*1080
Scale and layout: 125%
Target Program: SirsiDynix Symphony WorkFlows
重要:目標視窗要最大化
*/

MsgBox 歡迎使用簡易自動化腳本來協助您完成整批`n書目檔的查詢、建議權威的點擊與編輯步驟!
MsgBox 請您把要查詢的書本之ISBN條碼整理成bookList.txt`n放在此腳本的 bibliographicFiles 目錄之下`n`n接著您可以透過鍵盤組合建Alt+E開始執行`n`n在任何時候按下F12來暫停/繼續腳本`n`n在任何時候按下Esc來退出腳本

;按鍵Alt+E開始執行
!E:: 

  ;讀取文字檔 https://www.autohotkey.com/boards/viewtopic.php?t=90919
  FileRead, FileContent, bibliographicFiles/bookList.txt
  bookList := StrSplit(FileContent, "`r`n")

  ;在下方(數字3)更改本批要檢查書目檔的書籍數量
  ;bookCount := 3

  ;或是使用預設值(自動抓取清單中的書本數量)
  ; https://www.autohotkey.com/boards/viewtopic.php?t=31061
  bookCount := bookList.MaxIndex()
  MsgBox,, 書本清單數量, 本次清單共%bookCount%本書`n`n按下確定開始執行

  i := 1 ;變數i用來記錄目前做到第幾本書
  Loop, %bookCount%
  {
    clipboard := bookList[i]

    ;點選查詢欄位
    ClickPosition(418, 205, 1, 0, "Screen", true)
    Sleep 300

    ;鍵盤輸入滑鼠組合鍵
    ;https://www.autohotkey.com/boards/viewtopic.php?t=85456
    Send, ^a ; Ctrl + A
    Sleep 100
    Send, ^v ; Ctrl + V
    Sleep 100
    Send, {Enter}
    Sleep 600

    ;寫入剪貼簿到檔案(ISBN)
    ;https://www.autohotkey.com/boards/viewtopic.php?t=52164
    ;有加""比較安全，可以避免特殊文字造成欄位跑掉
    FileAppend, "%clipboard%"`,, bibliographicFiles/result.csv

    ;start of 自動建議權威區塊
    autoSuggetAuthFile()
    ;end of 自動建議權威區塊

    ;點索書號/館藏
    ClickPosition(603, 260, 1, 0, "Screen", true)
    Sleep 300

    ;點館藏條碼
    ClickPosition(1016, 565, 1, 0, "Screen", true)
    Sleep 100
    Send, ^a ; Ctrl + A
    Sleep 100
    Send, ^c ; Ctrl + C
    Sleep 100

    ;寫入剪貼簿到檔案(館藏條碼)
    FileAppend, "%clipboard%"`n, bibliographicFiles/result.csv

    ;點存儲
    ClickPosition(990, 990, 1, 0, "Screen", true)
    Sleep 100

    ;點返回檢索
    ClickPosition(900, 990, 1, 0, "Screen", true)
    Sleep 300

    i += 1
  }

  MsgBox 腳本順利執行完成!

return ;代表該區段腳本結束

; 此function從 自動建議權威檔案.ahk 移植過來
autoSuggetAuthFile(){
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
}
; 此function從 自動建議權威檔案.ahk 移植過來

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

;在任何時候按下F12來暫停腳本執行(可以恢復)
f12::
Pause
Suspend
return
;https://www.autohotkey.com/board/topic/60321-how-to-toggle-script-onoff-with-a-key/

;在任何時候按下ESC來中斷腳本執行(直接退出)
Esc::ExitApp
;https://www.autohotkey.com/boards/viewtopic.php?t=82622