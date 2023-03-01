/*
OS: Windows10
Screen Resolution: 1920*1080
Scale and layout: 125%
Target Program: SirsiDynix Symphony WorkFlows
���n:�ؼе����n�̤j��
*/

MsgBox �w��ϥ�²���۰ʤƸ}���Ө�U�z�����j�q�d�߳��o���y���X���I���B�J!
MsgBox �бz��n�d�ߪ��ѥ����X��z��bookList.txt`n��b�P���}���ۦP���ؿ����U`n���۱z�i�H�z�L��L�զX��Alt+E�}�l����

;����Alt+E�}�l����
!E:: 

  ;Ū����r�� https://www.autohotkey.com/boards/viewtopic.php?t=90919
  FileRead, FileContent, bookList.txt
  bookList := StrSplit(FileContent, "`r`n")

  i := 1
  ;�b�U��(�Ʀr3)��糧��n���o�����y�ƶq
  Loop, 3
  {
    clipboard := bookList[i]

    ;�g�J�ŶKï���G���ɮ�
    ;https://www.autohotkey.com/boards/viewtopic.php?t=52164
    FileAppend, "%clipboard%"`,, result.csv

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

    ;�즲�ѥ����D
    MouseClickDrag, left, 280, 208, 300, 235, 2
    Sleep 300
    Send, ^c ; Ctrl + C

    ;MsgBox %clipboard%

    ;�g�J�ŶKï���ɮ�(���D)
    ;���[""����w���A�i�H�קK�S�����D��r�y�����]��
    FileAppend, "%clipboard%"`,, result.csv

    ;�I���Ѹ�/�]��
    ClickPosition(603, 260, 1, 0, "Screen", true)
    Sleep 300

    ;�I�������
    ClickPosition(1450, 880, 1, 0, "Screen", true)
    Sleep 300
    Send, ^a ; Ctrl + A
    Sleep 100
    Send, ^c ; Ctrl + C
    Sleep 100

    ;�g�J�ŶKï���ɮ�(����)
    FileAppend, "%clipboard%"`,, result.csv
    Sleep 200

    ;�I�s�W���
    ClickPosition(461, 573, 1, 0, "Screen", true)
    Sleep 100
    Send, ^a ; Ctrl + A
    Sleep 100
    Send, ^c ; Ctrl + C
    Sleep 100

    ;�g�J�ŶKï���ɮ�(�s�W���)
    FileAppend, "%clipboard%"`n, result.csv

    ;�I��^�˯�
    ClickPosition(900, 990, 1, 0, "Screen", true)
    Sleep 300

    i += 1
  }

MsgBox �}�����Q���槹��!

return ;�N���ӰϬq�}������

;����Alt+G�}�l����
!G::
  ;�IŪ�̹�H��J�ءAŪ�̹�H��Jg
  ClickPosition(1835, 416, 1, 0, "Screen", true)
  Sleep 100
  Send g
return ;�N���ӰϬq�}������

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