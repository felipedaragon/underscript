unit UndHelper_Obj;

{
  UnderScript Helper object
  Copyright (c) 2013-2020 Felipe Daragon
  License: MIT (http://opensource.org/licenses/mit-license.php)
}

interface

uses
  Lua, pLua, Variants, UndConst, UndConsole;

type
{$METHODINFO ON}
  TUndHelper = class
  public
    LuaState: PLua_State;
    constructor Create;
    procedure Debug(s: String);
    procedure Write(s: String);
    procedure WriteLn(s: String);
    procedure Run(Script: String);
    function GetG(valName: String): Variant;
    procedure SetG(valName: String; const AValue: Variant);
    // getters local
    function GetL(valName: String): Variant;
    function GetLBoolean(valName: String): boolean;
    function GetLString(valName: String): String;
    function GetLInteger(valName: String): integer;
    // setters local
    procedure SetL(valName: String; const AValue: Variant);
    procedure SetLBoolean(valName: String; AValue: Boolean);
    procedure SetLString(valName: String; AValue: String);
    procedure SetLInteger(valName: String; AValue: Integer);
  end;
{$METHODINFO OFF}

var
  UndHelper: TUndHelper;

implementation

constructor TUndHelper.Create;
begin
  inherited Create;
end;

procedure TUndHelper.Run(Script: String);
begin
  luaL_loadbuffer(LuaState, PAnsiChar(AnsiString(Script)), Length(Script), nil);
  lua_pcall(LuaState, 0, 0, 0);
end;

procedure TUndHelper.SetL(valName: String; const AValue: Variant);
begin
  pLua_SetLocal(LuaState, valName, AValue);
end;

procedure TUndHelper.SetLString(valName: String; AValue: String);
begin
  pLua_SetLocal(LuaState, valName, AValue);
end;

procedure TUndHelper.SetLInteger(valName: String; AValue: Integer);
begin
  pLua_SetLocal(LuaState, valName, AValue);
end;

procedure TUndHelper.SetLBoolean(valName: String; AValue: Boolean);
begin
  pLua_SetLocal(LuaState, valName, AValue);
end;

function TUndHelper.GetL(valName: String): Variant;
var
  v: Variant;
begin
  try
    v := pLua_GetLocal(LuaState, valName);
  except
  end;
  //writeln('v is:'+v);
  result := v;
end;

function TUndHelper.GetLString(valName: String): string;
begin
  result := pLua_GetLocal(LuaState, valName);
end;

function TUndHelper.GetLBoolean(valName: String): boolean;
begin
  result := pLua_GetLocal(LuaState, valName);
end;

function TUndHelper.GetLInteger(valName: String): integer;
begin
  result := pLua_GetLocal(LuaState, valName);
end;

procedure TUndHelper.SetG(valName: String; const AValue: Variant);
var
  v: Variant;
begin
  v := AValue;
  try
    pLua_SetGlobal(LuaState, valName, v);
  except
  end;
end;

function TUndHelper.GetG(valName: String): Variant;
var
  v: Variant;
begin
  try
    v := pLua_GetGlobal(LuaState, valName);
  except
  end;
  result := v;
end;

procedure TUndHelper.Debug(s: String);
begin
  uConsoleDebug(LuaState, s);
end;

procedure TUndHelper.Write(s: String);
begin
  uConsoleWrite(LuaState, s);
end;

procedure TUndHelper.writeln(s: String);
begin
  uConsoleWriteLn(LuaState, s);
end;

initialization

UndHelper := TUndHelper.Create;

finalization

UndHelper.free;

end.
