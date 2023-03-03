/*
OS: Windows10
Screen Resolution: 1920*1080
Scale and layout: 125%
Target Program: SirsiDynix Symphony WorkFlows
���n:�ؼе����n�̤j��
*/

MsgBox �w��ϥ�²���۰ʤƸ}���Ө�U�z�������`n�ѥ��ɪ��d�ߡB��ĳ�v�ª��I���P�s��B�J!
MsgBox �бz��n�d�ߪ��ѥ���ISBN���X��z��bookList.txt`n��b���}���� bibliographicFiles �ؿ����U`n`n���۱z�i�H�z�L��L�զX��Alt+E�}�l����`n`n�b����ɭԫ��UF12�ӼȰ�/�~��}��`n`n�b����ɭԫ��UEsc�Ӱh�X�}��

;����Alt+E�}�l����
!E:: 

  ;Ū����r�� https://www.autohotkey.com/boards/viewtopic.php?t=90919
  FileRead, FileContent, bibliographicFiles/bookList.txt
  bookList := StrSplit(FileContent, "`r`n")

  ;�b�U��(�Ʀr3)��糧��n�ˬd�ѥ��ɪ����y�ƶq
  ;bookCount := 3

  ;�άO�ϥιw�]��(�۰ʧ���M�椤���ѥ��ƶq)
  ; https://www.autohotkey.com/boards/viewtopic.php?t=31061
  bookCount := bookList.MaxIndex()
  MsgBox,, �ѥ��M��ƶq, �����M��@%bookCount%����`n`n���U�T�w�}�l����

  i := 1 ;�ܼ�i�ΨӰO���ثe����ĴX����
  Loop, %bookCount%
  {
    clipboard := bookList[i]

    ;�I��d�����
    ClickPosition(418, 205, 1, 0, "Screen", true)
    Sleep 300

    ;��L��J�ƹ��զX��
    ;https://www.autohotkey.com/boards/viewtopic.php?t=85456
    Send, ^a ; Ctrl + A
    Sleep 100
    Send, ^v ; Ctrl + V
    Sleep 100
    Send, {Enter}
    Sleep 600

    ;�g�J�ŶKï���ɮ�(ISBN)
    ;https://www.autohotkey.com/boards/viewtopic.php?t=52164
    ;���[""����w���A�i�H�קK�S���r�y�����]��
    FileAppend, "%clipboard%"`,, bibliographicFiles/result.csv

    ;start of �۰ʫ�ĳ�v�°϶�
    autoSuggetAuthFile()
    ;end of �۰ʫ�ĳ�v�°϶�

    ;�I���Ѹ�/�]��
    ClickPosition(603, 260, 1, 0, "Screen", true)
    Sleep 300

    ;�I�]�ñ��X
    ClickPosition(1016, 565, 1, 0, "Screen", true)
    Sleep 100
    Send, ^a ; Ctrl + A
    Sleep 100
    Send, ^c ; Ctrl + C
    Sleep 100

    ;�g�J�ŶKï���ɮ�(�]�ñ��X)
    FileAppend, "%clipboard%"`n, bibliographicFiles/result.csv

    ;�I�s�x
    ClickPosition(990, 990, 1, 0, "Screen", true)
    Sleep 100

    ;�I��^�˯�
    ClickPosition(900, 990, 1, 0, "Screen", true)
    Sleep 300

    i += 1
  }

  MsgBox �}�����Q���槹��!

return ;�N��ӰϬq�}������

; ��function�q �۰ʫ�ĳ�v���ɮ�.ahk ���ӹL��
autoSuggetAuthFile(){
  ;YesNo��ܮ� https://www.autohotkey.com/docs/v1/lib/MsgBox.htm
  MsgBox, 4,, ���ѬO�_���M�~���y?`n(�I��O�|�۰ʶ�Jf�A�Ϥ��k���@����yg)
  ;IfMsgBox����h����O https://www.autohotkey.com/boards/viewtopic.php?t=74473
  IfMsgBox Yes
  classifyBookASprofessional()
  else
    classifyBookASgeneral()
  Sleep, 100

  ;�I�ˬd�v�ª����Ĥ�
  ClickPosition(290, 172, 1, 0, "Screen", true)
  Sleep 600

  While(!ClickPicture("images/finishedCheck.png", 1, 0,true,false))
  {
    ;�I��ĳ
    ClickPosition(1842, 429, 1, 0, "Screen", true)
    Sleep 600

    ;�IOK
    ClickPosition(1054, 1001, 1, 0, "Screen", true)
    Sleep 300

    ;�I�U�@��
    ClickPosition(1842, 211, 1, 0, "Screen", true)
    Sleep 300
  }

  ;�I�������窺OK(���s�W�v�¸��X���j��)
  ClickPosition(1082, 669, 1, 0, "Screen", true)
  Sleep 300

  ;�I�������窺OK(�p��)
  ClickPosition(1082, 636, 1, 0, "Screen", true)
  Sleep 300
}
; ��function�q �۰ʫ�ĳ�v���ɮ�.ahk ���ӹL��

;����Alt+G�}�l����
!G::
  classifyBookASgeneral()
return ;�N��ӰϬq�}������

classifyBookASgeneral(){
  ;�IŪ�̹�H��J�ءAŪ�̹�H��Jg(�@����y)
  ClickPosition(1835, 416, 1, 0, "Screen", true)
  Sleep 100
  Send g
}

;����Alt+F�}�l����AŪ�̹�H��Jf(�M�~���y)
!F::
  classifyBookASprofessional()
return ;�N��ӰϬq�}������

classifyBookASprofessional(){
  ;�IŪ�̹�H��J��
  ClickPosition(1835, 416, 1, 0, "Screen", true)
  Sleep 100
  Send f
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

;�b����ɭԫ��UF12�ӼȰ��}������(�i�H��_)
f12::
Pause
Suspend
return
;https://www.autohotkey.com/board/topic/60321-how-to-toggle-script-onoff-with-a-key/

;�b����ɭԫ��UESC�Ӥ��_�}������(�����h�X)
Esc::ExitApp
;https://www.autohotkey.com/boards/viewtopic.php?t=82622