/*
OS: Windows10
Screen Resolution: 1920*1080
Scale and layout: 125%
Target Program: SirsiDynix Symphony WorkFlows
���n:�ؼе����n�̤j��
*/

MsgBox �w��ϥ�²���۰ʤƸ}���Ө�U�z������ĳ�v���ɮת��I���B�J!
MsgBox �z�i�H�ѦҥH�U�ϥλ���: Alt+E�}�l����

;����Alt+E�}�l����
!E:: 

  ;�I�ˬd�v�ª����Ĥ�
  ClickPosition(290, 172, 1, 0, "Screen", true)
  Sleep 600

  Loop, 3
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

  ;�I���Ѹ�/�]��
  ClickPosition(550, 260, 1, 0, "Screen", true)
  Sleep 100

  ;�I�s�x
  ClickPosition(990, 990, 1, 0, "Screen", true)
  Sleep 100

  ;�ƹ����ܪ�^�˯�
  MouseMove, 900, 990

return ;�N���ӰϬq�}������

;����Alt+G�}�l����
!G::
  ;�IŪ�̹�H��J�ءAŪ�̹�H��Jg
  ClickPosition(1835, 416, 1, 0, "Screen", true)
  Sleep 100
  Send g
return ;�N���ӰϬq�}������

;����Alt+F�}�l����AŪ�̹�H��Jf
!F::
  ;�IŪ�̹�H��J��
  ClickPosition(1835, 416, 1, 0, "Screen", true)
  Sleep 100
  Send f
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