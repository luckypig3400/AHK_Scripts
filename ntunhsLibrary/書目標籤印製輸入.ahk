/*
OS: Windows10
Screen Resolution: 1920*1080
Scale and layout: 125%
Target Program: SirsiDynix Symphony WorkFlows
���n:�ؼе����n�̤j��
*/

MsgBox �w��ϥ�²���۰ʤƸ}���Ө�U�z�����n�L�s�ѼжK�Ȯ��y���X���I���B�J!
MsgBox �бz��n�d�ߪ��ѥ����X��z��bookList_stickers.txt`n��b�P���}���ۦP���ؿ����U`n���۱z�i�H�z�L��L�զX��Alt+E�}�l����

;����Alt+E�}�l����
!E:: 

  ;Ū����r�� https://www.autohotkey.com/boards/viewtopic.php?t=90919
  FileRead, FileContent, bookList_stickers.txt
  bookList := StrSplit(FileContent, "`r`n")
  
  i := 1
  ;�b�U��(�Ʀr3)��糧��M�椤�����y�ƶq
  ;Loop, 3
  ;�άO�ϥιw�]��(�۰ʧ���M�椤���ѥ��ƶq)
  ; https://www.autohotkey.com/boards/viewtopic.php?t=31061
  bookCount := bookList.MaxIndex()
  MsgBox,, �ѥ��M��ƶq, �����M��@%bookCount%����`n`n���U�T�w�}�l����
  Loop, %bookCount%
  {
    clipboard := bookList[i]

    ;�I���]�ñ��X��J��
    ClickPosition(513, 249, 1, 0, "Screen", true)
    Sleep 100

    ;��L��J�ƹ��զX��
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

  MsgBox �}�����Q���槹��!
return ;�N��ӰϬq�}������

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