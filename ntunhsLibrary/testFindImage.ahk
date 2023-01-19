MsgBox Alt+W開始執行找圖片測試

!W:: ClickPicture("images/chrome_bookmark_folder.png", 1, 0,true,false)

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
