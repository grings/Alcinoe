﻿unit Alcinoe.FMX.Dynamic.Layouts;

interface

{$I Alcinoe.inc}

uses
  Alcinoe.fmx.Dynamic.Controls;

{$REGION 'Auto-generated by <ALCINOE>\Tools\CodeBuilder (1)'}

type

  {~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
  TALDynamicLayout = class(TALDynamicExtendedControl)
  protected
    procedure Paint; override;
  public
    constructor Create(const AOwner: TObject); override;
  public
    //property Action;
    property Align;
    //**property Anchors;
    property AutoSize;
    //property CanFocus;
    //property CanParentFocus;
    //property DisableFocusEffect;
    property ClickSound;
    //**property ClipChildren;
    //property ClipParent;
    property Cursor;
    //property DoubleBuffered;
    //**property DragMode;
    //**property EnableDragHighlight;
    property Enabled;
    property Height;
    //property Hint;
    //property ParentShowHint;
    //property ShowHint;
    property HitTest default False;
    //**property Locked;
    property Margins;
    property Opacity;
    property Padding;
    //**property PopupMenu;
    //**property Position;
    property RotationAngle;
    //property RotationCenter;
    property Pivot;
    property Scale;
    //**property Size;
    //**property TabOrder;
    //**property TabStop;
    property TouchTargetExpansion;
    property Visible;
    property Width;
    //property OnCanFocus;
    //**property OnDragEnter;
    //**property OnDragLeave;
    //**property OnDragOver;
    //**property OnDragDrop;
    //**property OnDragEnd;
    //property OnEnter;
    //property OnExit;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;
    //**property OnMouseWheel;
    property OnClick;
    property OnDblClick;
    //property OnKeyDown;
    //property OnKeyUp;
    property OnPainting;
    property OnPaint;
    //property OnResize;
    //**property OnResized;
  end;

{$ENDREGION 'Auto-generated by <ALCINOE>\Tools\CodeBuilder (1)'}

implementation

{$REGION 'Auto-generated by <ALCINOE>\Tools\CodeBuilder (2)'}

{*********************************************************}
constructor TALDynamicLayout.Create(const AOwner: TObject);
begin
  inherited Create(AOwner);
  //**CanParentFocus := True;
  HitTest := False;
end;

{*******************************}
procedure TALDynamicLayout.Paint;
begin
  inherited;
  //**if (csDesigning in ComponentState) and not Locked then
  //**  DrawDesignBorder;
end;

{$ENDREGION 'Auto-generated by <ALCINOE>\Tools\CodeBuilder (2)'}

end.
