MsgBox Alt+W�}�l�����Ϥ�����

!W:: ClickPicture("images/chrome_bookmark_folder.png", 1, 0,true,false)

;�����ƹ��I���Ϥ�
ClickPicture(ImageFilePath,ClickCount:=1,Speed:=0,Return:=true,ShowError:=true){
    pos:=GetPicturePosition(ImageFilePath)
    if %pos%{
        posX:=pos[1]
        posY:=pos[2]
        ClickPosition(posX,posY,ClickCount,Speed,,Return)
        return [posX,posY]
    }else{
        if %ShowError% {
            MSGBOX �e�����䤣��Ϥ�`n %ImageFilePath%
        }
        return false
    }
    
}

;�����ƹ��I��
ClickPosition(posX,posY,ClickCount:=1,Speed:=0,CoordMode:="Screen",Return:=true){
    ;�Y�ϥά۹�Ҧ�
    if (CoordMode="Relative"){
        CoordMode,Mouse,Screen
        MouseGetPos, posX_i, posY_i ;�x�s��Ӫ��ƹ���m
        ;�ھ��I�����ƬO�_���s�Өϥ�MouseClick��MouseMove
        if %ClickCount%{
            MouseClick,,%posX%,%posY%,%ClickCount%,%Speed%,,R ;�I���۹��m
        }else{
            MouseMove, %posX%, %posY%,%Speed%
        }
    ;�Y�ϥΨ�L�Ҧ�
    }else{
        CoordMode,Mouse,%CoordMode%
        MouseGetPos, posX_i, posY_i ;�x�s��Ӫ��ƹ���m
        ;�ھ��I�����ƬO�_���s�Өϥ�MouseClick��MouseMove
        if %ClickCount%{
            MouseClick,,%posX%,%posY%,%ClickCount%,%Speed%
        }else{
            MouseMove, %posX%, %posY%,%Speed%
        }
    }
    ;�O�_�I�����^
    if %Return%{
        MouseMove, %posX_i%, %posY_i%,%Speed%
    }
    return
}

;����Ϥ�����m
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
