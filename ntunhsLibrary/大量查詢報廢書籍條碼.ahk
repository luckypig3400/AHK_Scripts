/*
OS: Windows10
Screen Resolution: 1920*1080
Scale and layout: 125%
Target Program: SirsiDynix Symphony WorkFlows
重要:目標視窗要最大化
*/

MsgBox 歡迎使用簡易自動化腳本來協助您完成大量查詢報廢書籍條碼的點擊步驟!
MsgBox 請您把要查詢的書本條碼整理成bookList.txt`n放在與此腳本相同的目錄之下`n接著您可以透過鍵盤組合建Alt+E開始執行

;按鍵Alt+E開始執行
!E:: 

;讀取文字檔 https://www.autohotkey.com/boards/viewtopic.php?t=90919
FileRead, FileContent, bookList.txt
bookList := StrSplit(FileContent, "`r`n")

i := 1
;在下方(數字3)更改本批要報廢的書籍數量
Loop, 3
{
clipboard := bookList[i]

;寫入剪貼簿結果到檔案
;https://www.autohotkey.com/boards/viewtopic.php?t=52164
FileAppend, "%clipboard%"`,, result.csv

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

;拖曳書本標題
MouseClickDrag, left, 280, 208, 300, 235, 2
Sleep 300
Send, ^c ; Ctrl + C

;MsgBox %clipboard%

;寫入剪貼簿到檔案(標題)
;有加""比較安全，可以避免特殊標題文字造成欄位跑掉
FileAppend, "%clipboard%"`,, result.csv

;點索書號/館藏
ClickPosition(603, 260, 1, 0, "Screen", true)
Sleep 300

;點價格欄位
ClickPosition(1450, 880, 1, 0, "Screen", true)
Sleep 300
Send, ^a ; Ctrl + A
Sleep 100
Send, ^c ; Ctrl + C
Sleep 100

;寫入剪貼簿到檔案(價格)
FileAppend, "%clipboard%"`,, result.csv
Sleep 200

;點新增日期
ClickPosition(461, 573, 1, 0, "Screen", true)
Sleep 100
Send, ^a ; Ctrl + A
Sleep 100
Send, ^c ; Ctrl + C
Sleep 100

;寫入剪貼簿到檔案(新增日期)
FileAppend, "%clipboard%"`n, result.csv

;點返回檢索
ClickPosition(900, 990, 1, 0, "Screen", true)
Sleep 300

i += 1
}

MsgBox 腳本順利執行完成!

return ;代表該區段腳本結束

;按鍵Alt+G開始執行
!G::
;點讀者對象輸入框，讀者對象填入g
ClickPosition(1835, 416, 1, 0, "Screen", true)
Sleep 100
Send g
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