unit Alcinoe.FMX.Memo;

interface

{$I Alcinoe.inc}

uses
  System.Types,
  system.Classes,
  System.UITypes,
  {$IF defined(android)}
  Alcinoe.FMX.NativeView.Android,
  {$ELSEIF defined(IOS)}
  System.TypInfo,
  iOSapi.Foundation,
  iOSapi.UIKit,
  Macapi.ObjectiveC,
  Alcinoe.iOSapi.UIKit,
  Alcinoe.FMX.NativeView.iOS,
  {$ELSEIF defined(ALMacOS)}
  System.TypInfo,
  Macapi.Foundation,
  Macapi.AppKit,
  Macapi.ObjectiveC,
  Macapi.ObjCRuntime,
  Macapi.CocoaTypes,
  Alcinoe.Macapi.AppKit,
  Alcinoe.FMX.NativeView.Mac,
  {$ELSEIF defined(MSWINDOWS)}
  Winapi.Messages,
  FMX.Controls.Win,
  Alcinoe.FMX.NativeView.Win,
  {$ENDIF}
  Fmx.controls,
  FMX.types,
  fmx.Graphics,
  Alcinoe.FMX.Controls,
  Alcinoe.FMX.Edit,
  Alcinoe.FMX.Common;

{$REGION ' ANDROID'}
{$IF defined(android)}
type

  {**************************************************}
  TALAndroidMemoControl = class(TALAndroidEditControl)
  public
    function getLineCount: integer; override;
  end;

{$endif}
{$ENDREGION}

{$REGION ' IOS'}
{$IF defined(ios)}
type

  {************************}
  TALIosMemoControl = class;

  {****************************************}
  IALIosMemoTextView = interface(UITextView)
    ['{EEF3FCE4-9755-48D7-B896-2C662EFDE9FC}']
    procedure touchesBegan(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesCancelled(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesEnded(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesMoved(touches: NSSet; withEvent: UIEvent); cdecl;
    function canBecomeFirstResponder: Boolean; cdecl;
    function becomeFirstResponder: Boolean; cdecl;
  end;

  {******************************************}
  TALIosMemoTextView = class(TALIosNativeView)
  private
    function GetView: UITextView;
    function GetControl: TALIosMemoControl;
  protected
    function GetObjectiveCClass: PTypeInfo; override;
  public
    procedure SetEnabled(const value: Boolean); override;
  public
    constructor Create; overload; override;
    procedure touchesBegan(touches: NSSet; withEvent: UIEvent); override; cdecl;
    procedure touchesCancelled(touches: NSSet; withEvent: UIEvent); override; cdecl;
    procedure touchesEnded(touches: NSSet; withEvent: UIEvent); override; cdecl;
    procedure touchesMoved(touches: NSSet; withEvent: UIEvent); override; cdecl;
    property View: UITextView read GetView;
    property Control: TALIosMemoControl read GetControl;
  end;

  {**************************************************************}
  TALIosMemoTextViewDelegate = class(TOCLocal, UITextViewDelegate)
  private
    FMemoControl: TALIosMemoControl;
  public
    constructor Create(const AMemoControl: TALIosMemoControl);
    procedure textViewDidBeginEditing(textView: UITextView); cdecl;
    procedure textViewDidChange(textView: UITextView); cdecl;
    procedure textViewDidChangeSelection(textView: UITextView); cdecl;
    procedure textViewDidEndEditing(textView: UITextView); cdecl;
    function textViewShouldBeginEditing(textView: UITextView): Boolean; cdecl;
    function textViewShouldEndEditing(textView: UITextView): Boolean; cdecl;
    [MethodName('textView:shouldChangeTextInRange:replacementText:')]
    function textViewShouldChangeTextInRangeReplacementText(textView: UITextView; shouldChangeTextInRange: NSRange; replacementText: NSString): Boolean; cdecl;
    [MethodName('textView:shouldInteractWithURL:inRange:')]
    function textViewShouldInteractWithURLInRange(textView: UITextView; shouldInteractWithURL: NSURL; inRange: NSRange): Boolean; cdecl;
    [MethodName('textView:shouldInteractWithTextAttachment:inRange:')]
    function textViewShouldInteractWithTextAttachmentInRange(textView: UITextView; shouldInteractWithTextAttachment: NSTextAttachment; inRange: NSRange): Boolean; cdecl;
  end;

  {*******************************************}
  TALIosMemoControl = class(TALBaseEditControl)
  private
    FTextViewDelegate: TALIosMemoTextViewDelegate;
    FPlaceholderLabel: UILabel;
    FFillColor: TAlphaColor;
    fMaxLength: integer;
    fPromptTextColor: TalphaColor;
  protected
    procedure DoChange; override;
    Function CreateNativeView: TALIosNativeView; override;
    function GetNativeView: TALIosMemoTextView; reintroduce; virtual;
    function GetKeyboardType: TVirtualKeyboardType; override;
    procedure setKeyboardType(const Value: TVirtualKeyboardType); override;
    function GetAutoCapitalizationType: TALAutoCapitalizationType; override;
    procedure setAutoCapitalizationType(const Value: TALAutoCapitalizationType); override;
    function GetPassword: Boolean; override;
    procedure setPassword(const Value: Boolean); override;
    function GetCheckSpelling: Boolean; override;
    procedure setCheckSpelling(const Value: Boolean); override;
    function GetReturnKeyType: TReturnKeyType; override;
    procedure setReturnKeyType(const Value: TReturnKeyType); override;
    function GetPromptText: String; override;
    procedure setPromptText(const Value: String); override;
    function GetPromptTextColor: TAlphaColor; override;
    procedure setPromptTextColor(const Value: TAlphaColor); override;
    function GetTintColor: TAlphaColor; override;
    procedure setTintColor(const Value: TAlphaColor); override;
    function GetFillColor: TAlphaColor; override;
    procedure SetFillColor(const Value: TAlphaColor); override;
    procedure TextSettingsChanged(Sender: TObject); override;
    function getText: String; override;
    procedure SetText(const Value: String); override;
    function GetMaxLength: integer; override;
    procedure SetMaxLength(const Value: integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getLineCount: integer; override;
    function getLineHeight: Single; override; // It includes the line spacing
    property NativeView: TALIosMemoTextView read GetNativeView;
    Procedure SetSelection(const AStart: integer; const AStop: Integer); overload; override;
    Procedure SetSelection(const AIndex: integer); overload; override;
  end;
{$endif}
{$ENDREGION}

{$REGION ' MacOS'}
{$IF defined(ALMacOS)}
type

  {************************}
  TALMacMemoControl = class;

  {********************************************}
  IALMacMemoScrollView = interface(NSScrollView)
    ['{00A5F139-8A09-43CA-AF31-05B3480DD657}']
    function acceptsFirstResponder: Boolean; cdecl;
    function becomeFirstResponder: Boolean; cdecl;
  end;

  {********************************************}
  TALMacMemoScrollView = class(TALMacNativeView)
  private
    function GetView: NSScrollView;
    function GetControl: TALMacMemoControl;
  protected
    function GetObjectiveCClass: PTypeInfo; override;
  public
    procedure SetEnabled(const value: Boolean); override;
  public
    constructor Create; overload; override;
    destructor Destroy; override;
    property View: NSScrollView read GetView;
    property Control: TALMacMemoControl read GetControl;
  end;

  {****************************************}
  IALMacMemoTextView = interface(NSTextView)
    ['{25DE9B6D-7F5F-462B-A785-145102C9D168}']
    function acceptsFirstResponder: Boolean; cdecl;
    function becomeFirstResponder: Boolean; cdecl;
  end;

  {**********************************}
  TALMacMemoTextView = class(TOCLocal)
  private
    FMemoControl: TALMacMemoControl;
    function GetView: NSTextView;
  protected
    function GetObjectiveCClass: PTypeInfo; override;
  public
    constructor Create(const AMemoControl: TALMacMemoControl); Virtual;
    function acceptsFirstResponder: Boolean; cdecl;
    function becomeFirstResponder: Boolean; cdecl;
    property View: NSTextView read GetView;
  end;

  {********************************************}
  IALMacMemoPlaceHolder = interface(NSTextField)
    ['{72231FBB-4D10-4463-8DF3-90BFC7E55AA6}']
    function acceptsFirstResponder: Boolean; cdecl;
  end;

  {*************************************}
  TALMacMemoPlaceHolder = class(TOCLocal)
  private
    FMemoControl: TALMacMemoControl;
    function GetView: NSTextField;
  protected
    function GetObjectiveCClass: PTypeInfo; override;
  public
    constructor Create(const AMemoControl: TALMacMemoControl); Virtual;
    function acceptsFirstResponder: Boolean; cdecl;
    property View: NSTextField read GetView;
  end;

  {************************************************************************************}
  TALMacMemoTextViewDelegate = class(TOCLocal, Alcinoe.Macapi.AppKit.NSTextViewDelegate)
  private
    FMemoControl: TALMacMemoControl;
  public
    constructor Create(const AMemoControl: TALMacMemoControl);
    function textShouldBeginEditing(textObject: NSText): Boolean; cdecl;
    function textShouldEndEditing(textObject: NSText): Boolean; cdecl;
    procedure textDidBeginEditing(notification: NSNotification); cdecl;
    procedure textDidEndEditing(notification: NSNotification); cdecl;
    procedure textDidChange(notification: NSNotification); cdecl;
    [MethodName('textView:shouldChangeTextInRange:replacementString:')]
    function textViewShouldChangeTextInRangeReplacementString(textView: NSTextView; shouldChangeTextInRange: NSRange; replacementString: NSString): boolean; cdecl;
  end;

  {*******************************************}
  TALMacMemoControl = class(TALBaseEditControl)
  private
    FTextView: TALMacMemoTextView;
    FTextViewDelegate: TALMacMemoTextViewDelegate;
    FPlaceholderLabel: TALMacMemoPlaceHolder;
    FFillColor: TAlphaColor;
    fMaxLength: integer;
    fReturnKeyType: TReturnKeyType;
    fKeyboardType: TVirtualKeyboardType;
    fAutoCapitalizationType: TALAutoCapitalizationType;
    fPassword: boolean;
    fCheckSpelling: boolean;
    fPromptTextColor: TalphaColor;
    fTintColor: TalphaColor;
  protected
    procedure DoChange; override;
    Function CreateNativeView: TALMacNativeView; override;
    function GetNativeView: TALMacMemoScrollView; reintroduce; virtual;
    function GetKeyboardType: TVirtualKeyboardType; override;
    procedure setKeyboardType(const Value: TVirtualKeyboardType); override;
    function GetAutoCapitalizationType: TALAutoCapitalizationType; override;
    procedure setAutoCapitalizationType(const Value: TALAutoCapitalizationType); override;
    function GetPassword: Boolean; override;
    procedure setPassword(const Value: Boolean); override;
    function GetCheckSpelling: Boolean; override;
    procedure setCheckSpelling(const Value: Boolean); override;
    function GetReturnKeyType: TReturnKeyType; override;
    procedure setReturnKeyType(const Value: TReturnKeyType); override;
    function GetPromptText: String; override;
    procedure setPromptText(const Value: String); override;
    function GetPromptTextColor: TAlphaColor; override;
    procedure setPromptTextColor(const Value: TAlphaColor); override;
    function GetTintColor: TAlphaColor; override;
    procedure setTintColor(const Value: TAlphaColor); override;
    function GetFillColor: TAlphaColor; override;
    procedure SetFillColor(const Value: TAlphaColor); override;
    procedure TextSettingsChanged(Sender: TObject); override;
    function getText: String; override;
    procedure SetText(const Value: String); override;
    function GetMaxLength: integer; override;
    procedure SetMaxLength(const Value: integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getLineCount: integer; override;
    function getLineHeight: Single; override; // It includes the line spacing
    property NativeView: TALMacMemoScrollView read GetNativeView;
    Procedure SetSelection(const AStart: integer; const AStop: Integer); overload; override;
    Procedure SetSelection(const AIndex: integer); overload; override;
  end;

{$endif}
{$ENDREGION}

{$REGION ' MSWINDOWS'}
{$IF defined(MSWINDOWS)}
type

  {************************************}
  TALWinMemoView = class(TALWinEditView)
  private
    procedure WMMouseWheel(var Message: TWMMouseWheel); message WM_MOUSEWHEEL;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

  {******************************************}
  TALWinMemoControl = class(TALWinEditControl)
  protected
    Function CreateNativeView: TALWinNativeView; override;
    function GetNativeView: TALWinMemoView; reintroduce; virtual;
  public
    function getLineCount: integer; override;
    property NativeView: TALWinMemoView read GetNativeView;
  end;

{$endif}
{$ENDREGION}

type

  {*************************}
  [ComponentPlatforms($FFFF)]
  TALMemo = class(TALBaseEdit)
  public
    type
      // -------------
      // TTextSettings
      TTextSettings = class(TALBaseEdit.TTextSettings)
      protected
        function GetDefaultVertAlign: TALTextVertAlign; override;
      published
        property LineHeightMultiplier;
      end;
      // -------------------
      // TDisabledStateStyle
      TDisabledStateStyle = class(TALBaseEdit.TDisabledStateStyle)
      public
        type
          TTextSettings = class(TALBaseEdit.TDisabledStateStyle.TTextSettings)
          protected
            function GetDefaultVertAlign: TALTextVertAlign; override;
          end;
      protected
        function CreateTextSettings(const AParent: TALBaseTextSettings): TALBaseEdit.TBaseStateStyle.TTextSettings; override;
      end;
      // ------------------
      // THoveredStateStyle
      THoveredStateStyle = class(TALBaseEdit.THoveredStateStyle)
      public
        type
          TTextSettings = class(TALBaseEdit.THoveredStateStyle.TTextSettings)
          protected
            function GetDefaultVertAlign: TALTextVertAlign; override;
          end;
      protected
        function CreateTextSettings(const AParent: TALBaseTextSettings): TALBaseEdit.TBaseStateStyle.TTextSettings; override;
      end;
      // ------------------
      // TFocusedStateStyle
      TFocusedStateStyle = class(TALBaseEdit.TFocusedStateStyle)
      public
        type
          TTextSettings = class(TALBaseEdit.TFocusedStateStyle.TTextSettings)
          protected
            function GetDefaultVertAlign: TALTextVertAlign; override;
          end;
      protected
        function CreateTextSettings(const AParent: TALBaseTextSettings): TALBaseEdit.TBaseStateStyle.TTextSettings; override;
      end;
      // ------------
      // TStateStyles
      TStateStyles = class(TALBaseEdit.TStateStyles)
      protected
        function CreateDisabledStateStyle(const AParent: TObject): TALBaseEdit.TDisabledStateStyle; override;
        function CreateHoveredStateStyle(const AParent: TObject): TALBaseEdit.THoveredStateStyle; override;
        function CreateFocusedStateStyle(const AParent: TObject): TALBaseEdit.TFocusedStateStyle; override;
      end;
  private
    FAutosizeLineCount: Integer;
    function GetTextSettings: TTextSettings;
    procedure SetTextSettings(const Value: TTextSettings);
  protected
    function GetDefaultSize: TSizeF; override;
    function GetAutoSize: TALAutoSizeMode; override;
    procedure SetAutosizeLineCount(const Value: Integer); virtual;
    function CreateStateStyles: TALBaseEdit.TStateStyles; override;
    function CreateTextSettings: TALBaseEdit.TTextSettings; override;
    function CreateEditControl: TALBaseEditControl; override;
    procedure AdjustSize; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    function HasUnconstrainedAutosizeWidth: Boolean; override;
  published
    property AutoSizeLineCount: Integer read FAutosizeLineCount write SetAutosizeLineCount Default 0;
    property TextSettings: TTextSettings read GetTextSettings write SetTextSettings;
  end;

  {***************************}
  TALDummyMemo = class(TALMemo)
  protected
    function CreateEditControl: TALBaseEditControl; override;
  end;

procedure Register;

implementation

uses
  System.SysUtils,
  System.Math,
  System.Math.Vectors,
  FMX.Utils,
  {$IF defined(IOS)}
  Macapi.CoreFoundation,
  iOSapi.CocoaTypes,
  Macapi.Helpers,
  FMX.Platform.iOS,
  FMX.Helpers.iOS,
  FMX.Consts,
  {$ELSEIF defined(ALMacOS)}
  system.Character,
  Macapi.CoreFoundation,
  Macapi.Helpers,
  Macapi.CoreText,
  FMX.Helpers.Mac,
  FMX.Consts,
  {$ELSEIF defined(MSWINDOWS)}
  Winapi.Windows,
  {$endif}
  {$IFDEF ALDPK}
  DesignIntf,
  {$ENDIF}
  Alcinoe.StringUtils,
  Alcinoe.FMX.Graphics,
  Alcinoe.Common;

{$REGION ' Android'}
{$IF defined(android)}

{***************************************************}
function TALAndroidMemoControl.getLineCount: integer;
begin
  result := NativeView.view.getLineCount;
end;

{$endif}
{$ENDREGION}

{$REGION ' IOS'}
{$IF defined(ios)}

{************************************}
constructor TALIosMemoTextView.Create;
begin
  inherited;
  var LUIColor := AlphaColorToUIColor(TalphaColorRec.Null);
  View.setbackgroundColor(LUIColor);
  //NOTE: If I try to release the LUIColor I have an exception so it's seam something acquire it
  var LUIEdgeInsets: UIEdgeInsets;
  LUIEdgeInsets.top := 0;
  LUIEdgeInsets.left := 0;
  LUIEdgeInsets.bottom := 0;
  LUIEdgeInsets.right := 0;
  View.setTextContainerInset(LUIEdgeInsets);
  TALUITextView.Wrap(NSObjectToID(View)).textContainer.setLineFragmentPadding(0);
end;

{************************************************************}
procedure TALIosMemoTextView.SetEnabled(const value: Boolean);
begin
  inherited;
  View.setEditable(value);
  TALUITextView.Wrap(NSObjectToID(View)).setSelectable(value);
end;

{****************************************************************************}
procedure TALIosMemoTextView.touchesBegan(touches: NSSet; withEvent: UIEvent);
begin
  if (Control.getLineCount < Control.Height / Control.getLineHeight) then
    inherited;
end;

{********************************************************************************}
procedure TALIosMemoTextView.touchesCancelled(touches: NSSet; withEvent: UIEvent);
begin
  if (Control.getLineCount < Control.Height / Control.getLineHeight) then
    inherited;
end;

{****************************************************************************}
procedure TALIosMemoTextView.touchesEnded(touches: NSSet; withEvent: UIEvent);
begin
  if (Control.getLineCount < Control.Height / Control.getLineHeight) then
    inherited;
end;

{****************************************************************************}
procedure TALIosMemoTextView.touchesMoved(touches: NSSet; withEvent: UIEvent);
begin
  if (Control.getLineCount < Control.Height / Control.getLineHeight) then
    inherited;
end;

{********************************************************}
function TALIosMemoTextView.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IALIosMemoTextView);
end;

{**********************************************}
function TALIosMemoTextView.GetView: UITextView;
begin
  Result := inherited GetView<UITextView>;
end;

{************************************************}
function TALIosMemoTextView.GetControl: TALIosMemoControl;
begin
  Result := TALIosMemoControl(inherited Control);
end;

{***********************************************************************************}
constructor TALIosMemoTextViewDelegate.Create(const AMemoControl: TALIosMemoControl);
begin
  inherited Create;
  FMemoControl := AMemoControl;
  if FMemoControl = nil then
    raise EArgumentNilException.Create(Format(SWrongParameter, ['AMemoControl']));
end;

{*********************************************************************************}
procedure TALIosMemoTextViewDelegate.TextViewDidBeginEditing(TextView: UITextView);
begin
end;

{***************************************************************************}
procedure TALIosMemoTextViewDelegate.textViewDidChange(textView: UITextView);
begin
  {$IF defined(DEBUG)}
  ALLog('TALIosMemoTextViewDelegate.textViewDidChange');
  {$ENDIF}
  fMemoControl.DoChange;
end;

{************************************************************************************}
procedure TALIosMemoTextViewDelegate.textViewDidChangeSelection(textView: UITextView);
begin
end;

{*******************************************************************************}
procedure TALIosMemoTextViewDelegate.textViewDidEndEditing(textView: UITextView);
begin
  TControl(FMemoControl.Owner).ResetFocus;
end;

{********************************************************************************************}
function TALIosMemoTextViewDelegate.textViewShouldBeginEditing(textView: UITextView): Boolean;
begin
  Result := True;
end;

{*****************************************************************************************************************************************************************************}
function TALIosMemoTextViewDelegate.textViewShouldChangeTextInRangeReplacementText(textView: UITextView; shouldChangeTextInRange: NSRange; replacementText: NSString): Boolean;
begin
  {$IF defined(DEBUG)}
  ALLog('TALIosMemoTextViewDelegate.textViewShouldChangeTextInRangeReplacementText');
  {$ENDIF}
  if FMemoControl.maxLength > 0 then begin
    var LText: NSString := textView.text;
    if shouldChangeTextInRange.length + shouldChangeTextInRange.location > LText.length then exit(false);
    result := LText.length + replacementText.length - shouldChangeTextInRange.length <= NSUInteger(FMemoControl.maxLength);
  end
  else Result := True;
end;

{******************************************************************************************}
function TALIosMemoTextViewDelegate.textViewShouldEndEditing(textView: UITextView): Boolean;
begin
  Result := True;
end;

{***************************************************************************************************************************************************************************************}
function TALIosMemoTextViewDelegate.textViewShouldInteractWithTextAttachmentInRange(textView: UITextView; shouldInteractWithTextAttachment: NSTextAttachment; inRange: NSRange): Boolean;
begin
  Result := True;
end;

{******************************************************************************************************************************************************}
function TALIosMemoTextViewDelegate.textViewShouldInteractWithURLInRange(textView: UITextView; shouldInteractWithURL: NSURL; inRange: NSRange): Boolean;
begin
  Result := True;
end;

{*******************************************************}
constructor TALIosMemoControl.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  FPlaceholderLabel := TUILabel.Wrap(TUILabel.Alloc.initWithFrame(RectToNSRect(TRect.Create(0,0,0,0))));
  FPlaceholderLabel.setHidden(True);
  NativeView.View.addSubview(FPlaceholderLabel);
  FTextViewDelegate := TALIosMemoTextViewDelegate.Create(Self);
  NativeView.View.setDelegate(FTextViewDelegate.GetObjectID);
  FFillColor := $ffffffff;
  fMaxLength := 0;
  fPromptTextColor := TalphaColors.Null;
  SetReturnKeyType(tReturnKeyType.Default);
  SetKeyboardType(TVirtualKeyboardType.default);
  setAutoCapitalizationType(TALAutoCapitalizationType.acNone);
  SetPassword(false);
  SetCheckSpelling(True);
end;

{***********************************}
destructor TALIosMemoControl.Destroy;
begin
  NativeView.View.setDelegate(nil);
  ALFreeAndNil(FTextViewDelegate);
  FPlaceholderLabel.removeFromSuperview;
  FPlaceholderLabel.release;
  inherited Destroy;
end;

{************************************************************}
Function TALIosMemoControl.CreateNativeView: TALIosNativeView;
begin

  // [NOTE] This workaround is no longer necessary, as the delphi framework (e.g., the virtual
  // keyboard service) already instantiates a UITextView internally during app startup,
  // which ensures that the Objective-C class is properly loaded and registered by the Delphi runtime.
  //
  // Originally, we had to create a UITextView instance explicitly to force the Objective-C class
  // (UITextView) to be registered. Without this, calling `TALIosWebView(inherited GetNativeView)`
  // could raise the following error:
  //   Unhandled Exception | Item not found
  //   At address: $0000000100365670
  //   (Generics.Collections.TDictionary<TTypeInfo*, TRegisteredDelphiClass*>.GetItem)
  //
  // Attempting to register the class manually like this:
  //   RegisterObjectiveCClass(TUITextView, TypeInfo(UITextView));
  // also fails with:
  //   Unhandled Exception | Method function someUITextViewMethod of class TUITextView not found
  //   At address: $00000001XXXXXXX
  //   (Macapi.Objectivec.TRegisteredDelphiClass.RegisterClass)
  //
  // Attempting to register our own wrapper class:
  //   RegisterObjectiveCClass(TALIosWebView, TypeInfo(IALIosWebView));
  // fails as well, with:
  //   Unhandled Exception | Objective-C class UITextView could not be found
  //   At address: $00000001046CA014
  //   (Macapi.Objectivec.ObjectiveCClassNotFound)
  //
  // The only reliable workaround is to instantiate a UITextView explicitly to force
  // the UIKit framework to be loaded and the class to be registered:
  //
  //if not IsUITextViewClassRegistered then begin
  //  var LUITextView := TUITextView.Wrap(TUITextView.Alloc.initWithFrame(CGRectMake(0, 0, 0, 0)));
  //  LUITextView.release;
  //  IsUITextViewClassRegistered := True;
  //end;

  result := TALIosMemoTextView.create(self);

end;

{***********************************************************}
function TALIosMemoControl.GetNativeView: TALIosMemoTextView;
begin
  result := TALIosMemoTextView(inherited GetNativeView);
end;

{*****************************************************************************}
procedure TALIosMemoControl.SetKeyboardType(const Value: TVirtualKeyboardType);
begin
  var LUIKeyboardType: UIKeyboardType;
  case Value of
    TVirtualKeyboardType.NumbersAndPunctuation: LUIKeyboardType := UIKeyboardTypeNumbersAndPunctuation;
    TVirtualKeyboardType.NumberPad:             LUIKeyboardType := UIKeyboardTypeNumberPad;
    TVirtualKeyboardType.PhonePad:              LUIKeyboardType := UIKeyboardTypePhonePad;
    TVirtualKeyboardType.Alphabet:              LUIKeyboardType := UIKeyboardTypeDefault;
    TVirtualKeyboardType.URL:                   LUIKeyboardType := UIKeyboardTypeURL;
    TVirtualKeyboardType.NamePhonePad:          LUIKeyboardType := UIKeyboardTypeNamePhonePad;
    TVirtualKeyboardType.EmailAddress:          LUIKeyboardType := UIKeyboardTypeEmailAddress;
    else {TVirtualKeyboardType.Default}         LUIKeyboardType := UIKeyboardTypeDefault;
  end;
  NativeView.View.setKeyboardType(LUIKeyboardType);
end;

{***************************************************************}
function TALIosMemoControl.GetKeyboardType: TVirtualKeyboardType;
begin
  var LUIKeyboardType := NativeView.View.KeyboardType;
  case LUIKeyboardType of
    UIKeyboardTypeNumbersAndPunctuation: result := TVirtualKeyboardType.NumbersAndPunctuation;
    UIKeyboardTypeNumberPad:             result := TVirtualKeyboardType.NumberPad;
    UIKeyboardTypePhonePad:              result := TVirtualKeyboardType.PhonePad;
    UIKeyboardTypeURL:                   result := TVirtualKeyboardType.URL;
    UIKeyboardTypeNamePhonePad:          result := TVirtualKeyboardType.NamePhonePad;
    UIKeyboardTypeEmailAddress:          result := TVirtualKeyboardType.EmailAddress;
    else                                 result := TVirtualKeyboardType.Default;
  end;
end;

{********************************************************************************************}
procedure TALIosMemoControl.setAutoCapitalizationType(const Value: TALAutoCapitalizationType);
begin
  var LUITextAutoCapitalizationType: UITextAutoCapitalizationType;
  case Value of
    TALAutoCapitalizationType.acWords:          LUITextAutoCapitalizationType := UITextAutoCapitalizationTypeWords;
    TALAutoCapitalizationType.acSentences:      LUITextAutoCapitalizationType := UITextAutoCapitalizationTypeSentences;
    TALAutoCapitalizationType.acAllCharacters:  LUITextAutoCapitalizationType := UITextAutoCapitalizationTypeAllCharacters;
    else {TALAutoCapitalizationType.acNone}     LUITextAutoCapitalizationType := UITextAutoCapitalizationTypeNone;
  end;
  NativeView.View.setAutoCapitalizationType(LUITextAutoCapitalizationType);
end;

{******************************************************************************}
function TALIosMemoControl.GetAutoCapitalizationType: TALAutoCapitalizationType;
begin
  var LUITextAutoCapitalizationType := NativeView.View.AutoCapitalizationType;
  case LUITextAutoCapitalizationType of
    UITextAutoCapitalizationTypeWords:         result := TALAutoCapitalizationType.acWords;
    UITextAutoCapitalizationTypeSentences:     result := TALAutoCapitalizationType.acSentences;
    UITextAutoCapitalizationTypeAllCharacters: result := TALAutoCapitalizationType.acAllCharacters;
    else                                       result := TALAutoCapitalizationType.acNone;
  end;
end;

{************************************************************}
procedure TALIosMemoControl.SetPassword(const Value: Boolean);
begin
  NativeView.View.setSecureTextEntry(Value);
end;

{**********************************************}
function TALIosMemoControl.GetPassword: Boolean;
begin
  result := NativeView.View.isSecureTextEntry;
end;

{*****************************************************************}
procedure TALIosMemoControl.SetCheckSpelling(const Value: Boolean);
begin
  if Value then begin
    NativeView.View.setSpellCheckingType(UITextSpellCheckingTypeYes);
    NativeView.View.setAutocorrectionType(UITextAutocorrectionTypeDefault);
  end
  else begin
    NativeView.View.setSpellCheckingType(UITextSpellCheckingTypeNo);
    NativeView.View.setAutocorrectionType(UITextAutocorrectionTypeNo);
  end;
end;

{***************************************************}
function TALIosMemoControl.GetCheckSpelling: Boolean;
begin
  result := NativeView.View.SpellCheckingType = UITextSpellCheckingTypeYes;
end;

{************************************************************************}
procedure TALIosMemoControl.setReturnKeyType(const Value: TReturnKeyType);
begin
  var LUIReturnKeyType: UIReturnKeyType;
  case Value of
    TReturnKeyType.Done:           LUIReturnKeyType := UIReturnKeyDone;
    TReturnKeyType.Go:             LUIReturnKeyType := UIReturnKeyGo;
    TReturnKeyType.Next:           LUIReturnKeyType := UIReturnKeyNext;
    TReturnKeyType.Search:         LUIReturnKeyType := UIReturnKeySearch;
    TReturnKeyType.Send:           LUIReturnKeyType := UIReturnKeySend;
    else {TReturnKeyType.Default}  LUIReturnKeyType := UIReturnKeyDefault;
  end;
  NativeView.View.setReturnKeyType(LUIReturnKeyType);
end;

{**********************************************************}
function TALIosMemoControl.GetReturnKeyType: TReturnKeyType;
begin
  var LUIReturnKeyType := NativeView.View.ReturnKeyType;
  case LUIReturnKeyType of
    UIReturnKeyDone:    result := TReturnKeyType.Done;
    UIReturnKeyGo:      result := TReturnKeyType.Go;
    UIReturnKeyNext:    result := TReturnKeyType.Next;
    UIReturnKeySearch:  result := TReturnKeyType.Search;
    UIReturnKeySend:    result := TReturnKeyType.Send;
    else                result := TReturnKeyType.Default;
  end;
end;

{***********************************************}
function TALIosMemoControl.GetPromptText: String;
begin
  Result := NSStrToStr(FPlaceholderLabel.text);
end;

{*************************************************************}
procedure TALIosMemoControl.setPromptText(const Value: String);
begin
  FPlaceholderLabel.setText(StrToNSStr(Value));
  FPlaceholderLabel.setHidden((not Text.IsEmpty) or (Value.IsEmpty));
  TextSettingsChanged(nil);
end;

{*********************************************************}
function TALIosMemoControl.GetPromptTextColor: TAlphaColor;
begin
  Result := fPromptTextColor;
end;

{***********************************************************************}
procedure TALIosMemoControl.setPromptTextColor(const Value: TAlphaColor);
begin
  if Value <> fPromptTextColor then begin
    fPromptTextColor := Value;
    TextSettingsChanged(nil);
  end;
end;

{***********************************}
procedure TALIosMemoControl.DoChange;
begin
  FPlaceholderLabel.setHidden((not Text.IsEmpty) or (PromptText.IsEmpty));
  inherited;
end;

{***************************************************}
function TALIosMemoControl.GetTintColor: TAlphaColor;
begin
  var red: CGFloat;
  var green: CGFloat;
  var blue: CGFloat;
  var alpha: CGFloat;
  if not NativeView.View.tintColor.getRed(@red, @green, @blue, @alpha) then result := TalphaColors.Null
  else result := TAlphaColorF.Create(red, green, blue, alpha).ToAlphaColor;
end;

{*****************************************************************}
procedure TALIosMemoControl.setTintColor(const Value: TAlphaColor);
begin
  if Value <> TalphaColors.Null then
    NativeView.View.setTintColor(AlphaColorToUIColor(Value));
end;

{*****************************************}
function TALIosMemoControl.getText: String;
begin
  result := NSStrToStr(NativeView.View.text);
end;

{*******************************************************}
procedure TALIosMemoControl.SetText(const Value: String);
begin
  NativeView.View.setText(StrToNSStr(Value));
end;

{***********************************************}
function TALIosMemoControl.GetMaxLength: integer;
begin
  Result := FMaxLength;
end;

{*************************************************************}
procedure TALIosMemoControl.SetMaxLength(const Value: integer);
begin
  FMaxLength := Value;
end;

{***************************************************************}
procedure TALIosMemoControl.TextSettingsChanged(Sender: TObject);
begin
  var LFontRef := ALCreateCTFontRef(ALResolveFontFamily(TextSettings.Font.Family), TextSettings.Font.Size, TextSettings.Font.Weight, TextSettings.Font.Slant);
  try

    // LineHeightMultiplier
    if not SameValue(textsettings.LineHeightMultiplier, 0, TEpsilon.Scale) then begin
      var LParagraphStyle: NSMutableParagraphStyle := TNSMutableParagraphStyle.Alloc;
      try
        LParagraphStyle.init;
        LParagraphStyle.setlineHeightMultiple(TextSettings.LineHeightMultiplier);

        var LObjects := TNSMutableArray.Create;
        var LForKeys := TNSMutableArray.Create;
        try
          LObjects.addObject(NSObjectToID(LParagraphStyle));
          LForKeys.addObject(NSObjectToID(NSParagraphStyleAttributeName));

          // If we call NativeView.View.setTypingAttributes before NativeView.View.setFont,
          // the font specified in NativeView.View.setFont will take precedence.
          // LObjects.addObject(LFontRef);
          // LForKeys.addObject(NSObjectToID(NSFontAttributeName));

          var LDictionary := TNSDictionary.Wrap(TNSDictionary.OCClass.dictionaryWithObjects(LObjects, LForKeys));
          TALUITextView.Wrap(NSObjectToID(NativeView.View)).setTypingAttributes(LDictionary);
          // I can't call LDictionary.release or I have an error
          // LDictionary.release;
        finally
          LObjects.release;
          LForKeys.release;
        end;
      finally
        LParagraphStyle.release;
      end;
    end
    else
       TALUITextView.Wrap(NSObjectToID(NativeView.View)).setTypingAttributes(nil);

    // Font
    NativeView.View.setFont(TUIFont.Wrap(LFontRef));

    // TextAlignment
    NativeView.View.setTextAlignment(ALTextHorzAlignToUITextAlignment(TextSettings.HorzAlign));

    // TextColor
    NativeView.View.setTextColor(AlphaColorToUIColor(TextSettings.Font.Color));

    // PlaceHolder Text Color
    var LUIColor: UIColor;
    if PromptTextColor <> tAlphaColors.Null then LUIColor := AlphaColorToUIColor(PromptTextColor)
    else LUIColor := AlphaColorToUIColor(
                       TAlphaColorF.Create(
                         ALSetColorAlpha(TextSettings.Font.Color, 0.5)).
                           PremultipliedAlpha.
                           ToAlphaColor);
    FPlaceholderLabel.setTextColor(LUIColor);

    // PlaceHolder Font
    FPlaceholderLabel.setfont(TUIFont.Wrap(LFontRef));
    FPlaceholderLabel.sizeToFit;

  finally
    CFRelease(LFontRef);
  end;
end;

{***************************************************}
function TALIosMemoControl.GetFillColor: TAlphaColor;
begin
  Result := FFillColor;
end;

{*****************************************************************}
procedure TALIosMemoControl.SetFillColor(const Value: TAlphaColor);
begin
  FFillColor := Value;
end;

{***********************************************}
function TALIosMemoControl.getLineCount: integer;
begin
  Result := 0;
  var LlayoutManager := TALUITextView.Wrap(NSObjectToID(NativeView.view)).layoutManager;
  var LnumberOfGlyphs := LlayoutManager.numberOfGlyphs;
  var LlineRange: NSRange;
  var LIndex: Integer := 0;
  while Lindex < LNumberOfGlyphs do begin
    // Get the range of the current line in the text view.
    LlayoutManager.lineFragmentRectForGlyphAtIndex(Lindex, @LlineRange);
    LIndex := NSMaxRange(LlineRange);
    inc(Result); // Increment the line count for each line fragment
  end;
  var LText := GetText;
  if (LText <> '') and (LText[high(LText)] = #10) then inc(result);
  if Result = 0 then result := 1;
end;

{***********************************************}
function TALIosMemoControl.getLineHeight: Single;
begin
  if NativeView.View.font = nil then
    TextSettingsChanged(nil);
  result := NativeView.View.font.lineHeight;
  if not SameValue(textsettings.LineHeightMultiplier, 0, TEpsilon.Scale) then
    result := result * textsettings.LineHeightMultiplier;
end;

{************************************************************************************}
Procedure TALIosMemoControl.setSelection(const AStart: integer; const AStop: Integer);
begin
  NativeView.View.setSelectedRange(NSMakeRange(AStart, AStop-AStart));
end;

{**************************************************************}
Procedure TALIosMemoControl.setSelection(const AIndex: integer);
begin
  NativeView.View.setSelectedRange(NSMakeRange(AIndex, 0));
end;

{$endif}
{$ENDREGION}

{$REGION ' MacOS'}
{$IF defined(ALMacOS)}

{**************************************}
constructor TALMacMemoScrollView.Create;
begin
  inherited;
  View.setDrawsBackground(false);
  View.setFocusRingType(NSFocusRingTypeNone);
end;

{**************************************}
destructor TALMacMemoScrollView.Destroy;
begin
  inherited;
end;

{**************************************************************}
procedure TALMacMemoScrollView.SetEnabled(const value: Boolean);
begin
  inherited;
  Control.FTextView.View.setEditable(value);
  Control.FTextView.View.setSelectable(value);
end;

{**********************************************************}
function TALMacMemoScrollView.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IALMacMemoScrollView);
end;

{**************************************************}
function TALMacMemoScrollView.GetView: NSScrollView;
begin
  Result := inherited GetView<NSScrollView>;
end;

{**************************************************}
function TALMacMemoScrollView.GetControl: TALMacMemoControl;
begin
  Result := TALMacMemoControl(inherited Control);
end;

{***************************************************************************}
constructor TALMacMemoTextView.Create(const AMemoControl: TALMacMemoControl);
begin
  inherited Create;
  FMemoControl := AMemoControl;
end;

{**********************************************}
function TALMacMemoTextView.GetView: NSTextView;
begin
  Result := NSTextView(Super);
end;

{********************************************************}
function TALMacMemoTextView.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IALMacMemoTextView);
end;

{*********************************************************}
function TALMacMemoTextView.acceptsFirstResponder: Boolean;
begin
  {$IF defined(DEBUG)}
  ALLog('TALMacMemoTextView.acceptsFirstResponder', 'control.name: ' + fMemoControl.parent.Name);
  {$ENDIF}
  Result := NSTextView(Super).acceptsFirstResponder and TControl(fMemoControl.Owner).canFocus;
end;

{********************************************************}
function TALMacMemoTextView.becomeFirstResponder: Boolean;
begin
  {$IF defined(DEBUG)}
  ALLog('TALMacMemoTextView.becomeFirstResponder', 'control.name: ' + fMemoControl.parent.Name);
  {$ENDIF}
  Result := NSTextView(Super).becomeFirstResponder;
  if (not TControl(FMemoControl.Owner).IsFocused) then
    TControl(FMemoControl.Owner).SetFocus;
end;

{***********************************************************************************}
constructor TALMacMemoTextViewDelegate.Create(const AMemoControl: TALMacMemoControl);
begin
  inherited Create;
  FMemoControl := AMemoControl;
  if FMemoControl = nil then
    raise EArgumentNilException.Create(Format(SWrongParameter, ['AMemoControl']));
end;

{*************************************************************************************}
procedure TALMacMemoTextViewDelegate.textDidBeginEditing(notification: NSNotification);
begin
end;

{*******************************************************************************}
procedure TALMacMemoTextViewDelegate.textDidChange(notification: NSNotification);
begin
  {$IF defined(DEBUG)}
  ALLog('TALMacMemoTextViewDelegate.textDidChange');
  {$ENDIF}
  fMemoControl.DoChange;
end;

{***********************************************************************************}
procedure TALMacMemoTextViewDelegate.textDidEndEditing(notification: NSNotification);
begin
  TControl(FMemoControl.Owner).ResetFocus;
end;

{**************************************************************************************}
function TALMacMemoTextViewDelegate.textShouldBeginEditing(textObject: NSText): Boolean;
begin
  Result := True;
end;

{*********************************************************************************************************************************************************************************}
function TALMacMemoTextViewDelegate.textViewShouldChangeTextInRangeReplacementString(textView: NSTextView; shouldChangeTextInRange: NSRange; replacementString: NSString): boolean;
begin
  {$IF defined(DEBUG)}
  ALLog('TALMacMemoTextViewDelegate.textViewShouldChangeTextInRangeReplacementText');
  {$ENDIF}
  if FMemoControl.maxLength > 0 then begin
    var LText: NSString := TALNSText.wrap(NSObjectToID(textView)).&String;
    if shouldChangeTextInRange.length + shouldChangeTextInRange.location > LText.length then exit(false);
    result := LText.length + replacementString.length - shouldChangeTextInRange.length <= NSUInteger(FMemoControl.maxLength);
  end
  else Result := True;
end;

{************************************************************************************}
function TALMacMemoTextViewDelegate.textShouldEndEditing(textObject: NSText): Boolean;
begin
  Result := True;
end;

{******************************************************************************}
constructor TALMacMemoPlaceHolder.Create(const AMemoControl: TALMacMemoControl);
begin
  inherited Create;
  FMemoControl := AMemoControl;
end;

{**************************************************}
function TALMacMemoPlaceHolder.GetView: NSTextField;
begin
  Result := NSTextField(Super);
end;

{***********************************************************}
function TALMacMemoPlaceHolder.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IALMacMemoPlaceHolder);
end;

{************************************************************}
function TALMacMemoPlaceHolder.acceptsFirstResponder: Boolean;
begin
  {$IF defined(DEBUG)}
  ALLog('TALMacMemoPlaceHolder.acceptsFirstResponder', 'control.name: ' + fMemoControl.parent.Name);
  {$ENDIF}
  Result := False;
  FmemoControl.NativeView.View.becomeFirstResponder;
end;

{*******************************************************}
constructor TALMacMemoControl.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  //--
  var LContentSize := NativeView.View.contentSize;
  FTextView := TALMacMemoTextView.Create(Self);
  FTextView.View.initWithFrame(RectToNSRect(TRectF.Create(0,0,LContentSize.width,LContentSize.height).round));
  FTextView.View.setAutoresizingMask(NSViewWidthSizable or NSViewHeightSizable);
  FTextView.View.setDrawsBackground(false);
  FTextView.View.setFocusRingType(NSFocusRingTypeNone);
  var LNSContainerInset: NSSize;
  LNSContainerInset.Width := 0;
  LNSContainerInset.Height := 0;
  FTextView.View.setTextContainerInset(LNSContainerInset);
  FTextView.View.textContainer.setLineFragmentPadding(0);
  //--
  FTextViewDelegate := TALMacMemoTextViewDelegate.Create(Self);
  TALNSTextView.Wrap(NSObjectToID(FTextView.View)).setDelegate(FTextViewDelegate.GetObjectID);
  //--
  FPlaceholderLabel := TALMacMemoPlaceHolder.Create(Self);
  FPlaceholderLabel.view.initWithFrame(RectToNSRect(TRect.Create(0,0,0,0)));
  FPlaceholderLabel.view.setEditable(False);
  FPlaceholderLabel.view.setSelectable(False);
  FPlaceholderLabel.view.setBordered(False);
  FPlaceholderLabel.view.setDrawsBackground(false);
  FPlaceholderLabel.view.setHidden(True);
  //--
  FTextView.View.addSubview(FPlaceholderLabel.view);
  NativeView.View.addSubview(FTextView.View);
  NativeView.view.setdocumentView(FTextView.View);
  //--
  FFillColor := $ffffffff;
  fMaxLength := 0;
  fReturnKeyType := tReturnKeyType.Default;
  fKeyboardType := TVirtualKeyboardType.default;
  fAutoCapitalizationType := TALAutoCapitalizationType.acNone;
  fPassword := false;
  fCheckSpelling := true;
  fPromptTextColor := TalphaColors.Null;
  FTintColor := TalphaColors.Null;
end;

{***********************************}
destructor TALMacMemoControl.Destroy;
begin
  FPlaceholderLabel.View.removeFromSuperview;
  ALFreeAndNil(FPlaceholderLabel);
  FTextView.View.setDelegate(nil);
  ALFreeAndNil(FTextViewDelegate);
  FTextView.View.removeFromSuperview;
  ALFreeAndNil(FTextView);
  inherited Destroy;
end;

{************************************************************}
Function TALMacMemoControl.CreateNativeView: TALMacNativeView;
begin
  result := TALMacMemoScrollView.create(self);
end;

{*************************************************************}
function TALMacMemoControl.GetNativeView: TALMacMemoScrollView;
begin
  result := TALMacMemoScrollView(inherited GetNativeView);
end;

{*****************************************************************************}
procedure TALMacMemoControl.SetKeyboardType(const Value: TVirtualKeyboardType);
begin
  FKeyboardType := Value;
end;

{***************************************************************}
function TALMacMemoControl.GetKeyboardType: TVirtualKeyboardType;
begin
  Result := FKeyboardType;
end;

{********************************************************************************************}
procedure TALMacMemoControl.setAutoCapitalizationType(const Value: TALAutoCapitalizationType);
begin
  FAutoCapitalizationType := Value;
end;

{******************************************************************************}
function TALMacMemoControl.GetAutoCapitalizationType: TALAutoCapitalizationType;
begin
  Result := FAutoCapitalizationType;
end;

{************************************************************}
procedure TALMacMemoControl.SetPassword(const Value: Boolean);
begin
  FPassword := Value;
end;

{**********************************************}
function TALMacMemoControl.GetPassword: Boolean;
begin
  Result := FPassword;
end;

{*****************************************************************}
procedure TALMacMemoControl.SetCheckSpelling(const Value: Boolean);
begin
  FCheckSpelling := Value;
end;

{***************************************************}
function TALMacMemoControl.GetCheckSpelling: Boolean;
begin
  Result := FCheckSpelling;
end;

{************************************************************************}
procedure TALMacMemoControl.setReturnKeyType(const Value: TReturnKeyType);
begin
  FReturnKeyType := Value;
end;

{**********************************************************}
function TALMacMemoControl.GetReturnKeyType: TReturnKeyType;
begin
  Result := FReturnKeyType;
end;

{***********************************************}
function TALMacMemoControl.GetPromptText: String;
begin
  Result := NSStrToStr(FPlaceholderLabel.view.stringValue);
end;

{*************************************************************}
procedure TALMacMemoControl.setPromptText(const Value: String);
begin
  FPlaceholderLabel.view.setStringValue(StrToNSStr(Value));
  FPlaceholderLabel.view.setHidden((not Text.IsEmpty) or (Value.IsEmpty));
  TextSettingsChanged(nil);
end;

{*********************************************************}
function TALMacMemoControl.GetPromptTextColor: TAlphaColor;
begin
  Result := fPromptTextColor;
end;

{***********************************************************************}
procedure TALMacMemoControl.setPromptTextColor(const Value: TAlphaColor);
begin
  if Value <> fPromptTextColor then begin
    fPromptTextColor := Value;
    TextSettingsChanged(nil);
  end;
end;

{***********************************}
procedure TALMacMemoControl.DoChange;
begin
  FPlaceholderLabel.view.setHidden((not Text.IsEmpty) or (PromptText.IsEmpty));
  inherited;
end;

{***************************************************}
function TALMacMemoControl.GetTintColor: TAlphaColor;
begin
  Result := FTintColor;
end;

{*****************************************************************}
procedure TALMacMemoControl.setTintColor(const Value: TAlphaColor);
begin
  FTintColor := Value;
end;

{*****************************************}
function TALMacMemoControl.getText: String;
begin
  result := NSStrToStr(TALNSText.wrap(NSObjectToID(FtextView.View)).&String);
end;

{*******************************************************}
procedure TALMacMemoControl.SetText(const Value: String);
begin
  FtextView.View.setString(StrToNSStr(Value));
end;

{***********************************************}
function TALMacMemoControl.GetMaxLength: integer;
begin
  Result := FMaxLength;
end;

{*************************************************************}
procedure TALMacMemoControl.SetMaxLength(const Value: integer);
begin
  FMaxLength := Value;
end;

{***************************************************************}
procedure TALMacMemoControl.TextSettingsChanged(Sender: TObject);
begin
  var LFontRef := ALCreateCTFontRef(ALResolveFontFamily(TextSettings.Font.Family), TextSettings.Font.Size, TextSettings.Font.Weight, TextSettings.Font.Slant);
  try

    // LineHeightMultiplier
    if not SameValue(textsettings.LineHeightMultiplier, 0, TEpsilon.Scale) then begin
      var LParagraphStyle: NSMutableParagraphStyle := TNSMutableParagraphStyle.Alloc;
      try
        LParagraphStyle.init;
        LParagraphStyle.setlineHeightMultiple(TextSettings.LineHeightMultiplier);

        var LObjects := TNSMutableArray.Create;
        var LForKeys := TNSMutableArray.Create;
        try
          LObjects.addObject(NSObjectToID(LParagraphStyle));
          LForKeys.addObject(NSObjectToID(NSParagraphStyleAttributeName));

          // If we call NativeView.View.setTypingAttributes before NativeView.View.setFont,
          // the font specified in NativeView.View.setFont will take precedence.
          // LObjects.addObject(LFontRef);
          // LForKeys.addObject(NSObjectToID(NSFontAttributeName));

          var LDictionary := TNSDictionary.Wrap(TNSDictionary.OCClass.dictionaryWithObjects(LObjects, LForKeys));
          FTextView.View.setTypingAttributes(LDictionary);
          // I can't call LDictionary.release or I have an error
          // LDictionary.release;
        finally
          LObjects.release;
          LForKeys.release;
        end;
      finally
        LParagraphStyle.release;
      end;
    end
    else
      FTextView.View.setTypingAttributes(nil);

    // Font
    FTextView.View.setFont(TNSFont.Wrap(LFontRef));

    // TextAlignment
    var LRange: NSRange;
    LRange.location := 0;
    LRange.length := GetText.Length;
    FTextView.View.setAlignment(ALTextHorzAlignToNSTextAlignment(TextSettings.HorzAlign), LRange);

    // TextColor
    FTextView.View.setTextColor(AlphaColorToNSColor(TextSettings.Font.Color));

    // PlaceHolder Text Color
    var LNSColor: NSColor;
    if PromptTextColor <> tAlphaColors.Null then LNSColor := AlphaColorToNSColor(PromptTextColor)
    else LNSColor := AlphaColorToNSColor(
                       TAlphaColorF.Create(
                         ALSetColorAlpha(TextSettings.Font.Color, 0.5)).
                           PremultipliedAlpha.
                           ToAlphaColor);
    FPlaceholderLabel.view.setTextColor(LNSColor);

    // PlaceHolder Font
    FPlaceholderLabel.view.setfont(TNSFont.Wrap(LFontRef));
    FPlaceholderLabel.view.sizeToFit;

  finally
    CFRelease(LFontRef);
  end;
end;

{***************************************************}
function TALMacMemoControl.GetFillColor: TAlphaColor;
begin
  Result := FFillColor;
end;

{*****************************************************************}
procedure TALMacMemoControl.SetFillColor(const Value: TAlphaColor);
begin
  FFillColor := Value;
end;

{***********************************************}
function TALMacMemoControl.getLineCount: integer;
begin
  Result := 0;
  var LlayoutManager := FtextView.View.layoutManager;
  var LnumberOfGlyphs := LlayoutManager.numberOfGlyphs;
  var LlineRange: NSRange;
  var LIndex: Integer := 0;
  while Lindex < LNumberOfGlyphs do begin
    // Get the range of the current line in the text view.
    LlayoutManager.lineFragmentRectForGlyphAtIndex(Lindex, @LlineRange);
    LIndex := NSMaxRange(LlineRange);
    inc(Result); // Increment the line count for each line fragment
  end;
  var LText := GetText;
  if (LText <> '') and (LText[high(LText)] = #10) then inc(result);
  if Result = 0 then result := 1;
end;

{***********************************************}
function TALMacMemoControl.getLineHeight: Single;
begin
  var LfontMetrics := ALGetFontMetrics(
                        ALResolveFontFamily(TextSettings.Font.Family), // const AFontFamily: String;
                        TextSettings.Font.Size, // const AFontSize: single;
                        TextSettings.Font.Weight, // const AFontWeight: TFontWeight;
                        TextSettings.Font.Slant); // const AFontSlant: TFontSlant;
  result := -LfontMetrics.Ascent + LfontMetrics.Descent + LfontMetrics.Leading;
  if not SameValue(textsettings.LineHeightMultiplier, 0, TEpsilon.Scale) then
    result := result * textsettings.LineHeightMultiplier;
end;

{************************************************************************************}
Procedure TALMacMemoControl.setSelection(const AStart: integer; const AStop: Integer);
begin
  FTextView.View.setSelectedRange(NSMakeRange(AStart, AStop-AStart));
end;

{**************************************************************}
Procedure TALMacMemoControl.setSelection(const AIndex: integer);
begin
  FTextView.View.setSelectedRange(NSMakeRange(AIndex, 0));
end;

{$endif}
{$ENDREGION}

{$REGION ' MSWINDOWS'}
{$IF defined(MSWINDOWS)}

{***************************************************************}
procedure TALWinMemoView.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style and not ES_AUTOHSCROLL;
  Params.Style := Params.Style or ES_AUTOVSCROLL or ES_MULTILINE;
end;

{****************************************************************}
procedure TALWinMemoView.WMMouseWheel(var Message: TWMMouseWheel);
begin
  if (not TControl(Control.Owner).IsFocused) or
     (Control.getLineCount < Control.Height / Control.getLineHeight)  then inherited
  else begin
    if (Message.WheelDelta > 0) then
      SendMessage(Handle, EM_LINESCROLL, 0, -1)
    else if (Message.WheelDelta < 0) then
      SendMessage(Handle, EM_LINESCROLL, 0, 1);
  end;
end;

{************************************************************}
Function TALWinMemoControl.CreateNativeView: TALWinNativeView;
begin
  {$IF defined(ALDPK)}
  Result := nil;
  {$ELSE}
  Result := TALWinMemoView.create(self);
  {$ENDIF}
end;

{*******************************************************}
function TALWinMemoControl.GetNativeView: TALWinMemoView;
begin
  Result := TALWinMemoView(inherited GetNativeView);
end;

{***********************************************}
function TALWinMemoControl.getLineCount: integer;
begin
  {$IF not defined(ALDPK)}
  Result := SendMessage(NativeView.Handle, EM_GETLINECOUNT, 0, 0);
  {$else}
  Result := 1;
  {$endif}
end;

{$endif}
{$ENDREGION}

{***************************************************************************************}
function TALMemo.TDisabledStateStyle.TTextSettings.GetDefaultVertAlign: TALTextVertAlign;
begin
  Result := TALTextVertAlign.Leading;
end;

{*************************************************************************************************************************************}
function TALMemo.TDisabledStateStyle.CreateTextSettings(const AParent: TALBaseTextSettings): TALBaseEdit.TBaseStateStyle.TTextSettings;
begin
  Result := TTextSettings.Create(AParent);
end;

{**************************************************************************************}
function TALMemo.THoveredStateStyle.TTextSettings.GetDefaultVertAlign: TALTextVertAlign;
begin
  Result := TALTextVertAlign.Leading;
end;

{************************************************************************************************************************************}
function TALMemo.THoveredStateStyle.CreateTextSettings(const AParent: TALBaseTextSettings): TALBaseEdit.TBaseStateStyle.TTextSettings;
begin
  Result := TTextSettings.Create(AParent);
end;

{**************************************************************************************}
function TALMemo.TFocusedStateStyle.TTextSettings.GetDefaultVertAlign: TALTextVertAlign;
begin
  Result := TALTextVertAlign.Leading;
end;

{************************************************************************************************************************************}
function TALMemo.TFocusedStateStyle.CreateTextSettings(const AParent: TALBaseTextSettings): TALBaseEdit.TBaseStateStyle.TTextSettings;
begin
  Result := TTextSettings.Create(AParent);
end;

{**************************************************************************************************************}
function TALMemo.TStateStyles.CreateDisabledStateStyle(const AParent: TObject): TALBaseEdit.TDisabledStateStyle;
begin
  result := TDisabledStateStyle.Create(AParent);
end;

{************************************************************************************************************}
function TALMemo.TStateStyles.CreateHoveredStateStyle(const AParent: TObject): TALBaseEdit.THoveredStateStyle;
begin
  result := THoveredStateStyle.Create(AParent);
end;

{************************************************************************************************************}
function TALMemo.TStateStyles.CreateFocusedStateStyle(const AParent: TObject): TALBaseEdit.TFocusedStateStyle;
begin
  Result := TFocusedStateStyle.Create(AParent);
end;

{*******************************************************************}
function TALMemo.TTextSettings.GetDefaultVertAlign: TALTextVertAlign;
begin
  result := TALTextVertAlign.Leading;
end;

{*********************************************}
constructor TALMemo.Create(AOwner: TComponent);
begin
  inherited;
  FAutosizeLineCount := 0;
end;

{********************************************}
procedure TALMemo.Assign(Source: TPersistent);
begin
  BeginUpdate;
  Try
    if Source is TALMemo then begin
      AutosizeLineCount := TALMemo(Source).AutoSizeLineCount;
    end
    else
      ALAssignError(Source{ASource}, Self{ADest});
    inherited Assign(Source);
  Finally
    EndUpdate;
  End;
end;

{***********************************************************}
function TALMemo.CreateStateStyles: TALBaseEdit.TStateStyles;
begin
  Result := TStateStyles.Create(self);
end;

{*************************************************************}
function TALMemo.CreateTextSettings: TALBaseEdit.TTextSettings;
begin
  result := TTextSettings.Create;
end;

{*****************************************************}
function TALMemo.CreateEditControl: TALBaseEditControl;
begin
  {$IF defined(android)}
  Result := TALAndroidMemoControl.Create(self, true{aIsMultiline}, DefStyleAttr, DefStyleRes);
  {$ELSEIF defined(ios)}
  Result := TALIosMemoControl.Create(self);
  {$ELSEIF defined(ALMacOS)}
  Result := TALMacMemoControl.Create(self);
  {$ELSEIF defined(MSWindows)}
  Result := TALWinMemoControl.Create(self);
  {$ENDIF}
end;

{**********************************************}
function TALMemo.GetTextSettings: TTextSettings;
begin
  result := TTextSettings(inherited TextSettings);
end;

{************************************************************}
procedure TALMemo.SetTextSettings(const Value: TTextSettings);
begin
  inherited TextSettings := Value;
end;

{***************************}
procedure TALMemo.AdjustSize;
begin
  if (not (csLoading in ComponentState)) and // loaded will call again AdjustSize
     (not (csDestroying in ComponentState)) and // if csDestroying do not do autosize
     (TNonReentrantHelper.EnterSection(FIsAdjustingSize)) then begin // non-reantrant
    try

      if isupdating then begin
        FAdjustSizeOnEndUpdate := True;
        Exit;
      end
      else
        FAdjustSizeOnEndUpdate := False;

      {$IF defined(debug)}
      //ALLog(ClassName + '.AdjustSize', 'Name: ' + Name + ' | HasUnconstrainedAutosize(X/Y) : '+ALBoolToStrW(HasUnconstrainedAutosizeWidth)+'/'+ALBoolToStrW(HasUnconstrainedAutosizeHeight));
      {$ENDIF}

      Var LInlinedLabelText := (LabelText <> '') and (LabelTextSettings.Layout = TLabelTextLayout.Inline);
      if LInlinedLabelText then MakeBufLabelTextDrawable;

      var LStrokeSize := TRectF.Empty;
      if Stroke.HasStroke then begin
        if (TSide.Top in Sides) then    LStrokeSize.Top :=    max(Stroke.Thickness - Padding.top,    0);
        if (TSide.bottom in Sides) then LStrokeSize.bottom := max(Stroke.Thickness - Padding.bottom, 0);
        if (TSide.right in Sides) then  LStrokeSize.right :=  max(Stroke.Thickness - Padding.right,  0);
        if (TSide.left in Sides) then   LStrokeSize.left :=   max(Stroke.Thickness - Padding.left,   0);
      end;

      if HasUnconstrainedAutosizeHeight then begin

        var LLineHeight: Single := GetLineHeight;
        if AutoAlignToPixel then LLineHeight := ALAlignDimensionToPixelRound(LLineHeight, ALGetScreenScale, TEpsilon.Position);

        var LAdjustement: Single := ((LLineHeight / 100) * 25);
        if AutoAlignToPixel then LAdjustement := ALAlignDimensionToPixelRound(LAdjustement, ALGetScreenScale, TEpsilon.Position);

        If LInlinedLabelText then begin
          SetFixedSizeBounds(
            Position.X,
            Position.Y,
            Width,
            (LLineHeight * AutoSizeLineCount) + LAdjustement + LStrokeSize.Top + LStrokeSize.bottom + padding.Top + padding.Bottom + BufLabelTextDrawableRect.Height + LabelTextSettings.Margins.Top + LabelTextSettings.Margins.bottom);
        end
        else begin
          SetFixedSizeBounds(
            Position.X,
            Position.Y,
            Width,
            (LLineHeight * AutoSizeLineCount) + LAdjustement + LStrokeSize.Top + LStrokeSize.bottom + padding.Top + padding.Bottom);
        end;

      end;

      var LMarginRect := TRectF.Empty;

      if LInlinedLabelText then
        LMarginRect.top := BufLabelTextDrawableRect.Height + LabelTextSettings.Margins.Top + LabelTextSettings.Margins.bottom;

      LMarginRect.left :=   Max(LMarginRect.left   + LStrokeSize.left,   0);
      LMarginRect.Top :=    Max(LMarginRect.Top    + LStrokeSize.Top,    0);
      LMarginRect.Right :=  Max(LMarginRect.Right  + LStrokeSize.Right,  0);
      LMarginRect.Bottom := Max(LMarginRect.Bottom + LStrokeSize.Bottom, 0);

      EditControl.Margins.Rect := LMarginRect;

    finally
      TNonReentrantHelper.LeaveSection(FIsAdjustingSize)
    end;
  end;
end;

{******************************************************}
function TALMemo.HasUnconstrainedAutosizeWidth: Boolean;
begin
  result := False;
end;

{**************************************}
function TALMemo.GetDefaultSize: TSizeF;
begin
  Result := TSizeF.Create(200, 75);
end;

{********************************************}
function TALMemo.GetAutoSize: TALAutoSizeMode;
begin
  if FAutoSizeLineCount > 0 then Result := TALAutoSizeMode.Height
  else Result := TALAutoSizeMode.None;
end;

{***********************************************************}
procedure TALMemo.SetAutosizeLineCount(const Value: Integer);
begin
  if FAutoSizeLineCount <> Value then begin
    FAutoSizeLineCount := Max(0, Value);
    AdjustSize;
  end;
end;

{**********************************************************}
function TALDummyMemo.CreateEditControl: TALBaseEditControl;
begin
  Result := TALDummyEditControl.Create(self);
end;

{*****************}
procedure Register;
begin
  RegisterComponents('Alcinoe', [TALMemo]);
  {$IFDEF ALDPK}
  UnlistPublishedProperty(TALMemo, 'Size');
  UnlistPublishedProperty(TALMemo, 'StyleName');
  UnlistPublishedProperty(TALMemo, 'OnTap');
  {$ENDIF}
end;

initialization
  {$IF defined(DEBUG)}
  ALLog('Alcinoe.FMX.Memo','initialization');
  {$ENDIF}
  RegisterFmxClasses([TALMemo]);

end.
