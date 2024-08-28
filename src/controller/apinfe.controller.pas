unit apinfe.controller;

interface

uses
  System.Classes,
  apinfe.controller.base;

type
  TControllerApi = class(TControllerApiBase)
    private
       //
    public
    //
    published
      constructor Create;
  end;

implementation

{ TControllerApi }


{ TControllerApi }

constructor TControllerApi.Create;
begin
 inherited Create;
end;

end.
