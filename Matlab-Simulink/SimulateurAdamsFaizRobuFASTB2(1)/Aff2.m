function varargout = Aff2(varargin)
% AFF2 M-file for Aff2.fig
%      AFF2, by itself, creates a new AFF2 or raises the existing
%      singleton*.
%
%      H = AFF2 returns the handle to a new AFF2 or the handle to
%      the existing singleton*.
%
%      AFF2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AFF2.M with the given input arguments.
%
%      AFF2('Property','Value',...) creates a new AFF2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Aff2_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Aff2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Aff2

% Last Modified by GUIDE v2.5 02-Mar-2009 13:49:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Aff2_OpeningFcn, ...
                   'gui_OutputFcn',  @Aff2_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Aff2 is made visible.
function Aff2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Aff2 (see VARARGIN)

% Choose default command line output for Aff2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Aff2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Aff2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
N=findobj('tag','FigResultat');
close(N)
ResultatsFig;
Donnees=evalin('base','Resultat');

%affiche Elat
N=findobj('tag','Elat')
axes(N)
plot(Donnees(:,1),'k')
grid on
hold on
plot(Donnees(:,22),'r')

% affiche ECap
N=findobj('tag','Ecap');
axes(N)
plot(Donnees(:,2)*180/pi,'k')
grid on
hold on
plot(Donnees(:,23)*180/pi,'k')

% affiche angle braquage
N=findobj('tag','StAngle');
axes(N)
plot(Donnees(:,25)*180/pi,'k')
hold on
%plot(Donnees(:,31)*180/pi,'b')
grid on
hold off

% affiche d�rives
N=findobj('tag','Beta');
axes(N)
hold on
plot(Donnees(:,9)*180/pi,'k')
plot(Donnees(:,10)*180/pi,'k')
plot(Donnees(:,11)*180/pi,'.b')
plot(Donnees(:,12)*180/pi,'.r')
grid on
hold off

% affiche Vitesse lacet
N=findobj('tag','VitCap');
axes(N)
hold on
plot(Donnees(:,5)*180/pi,'k')
plot(Donnees(:,13)*180/pi,'b')
plot(Donnees(:,19)*180/pi,'r')
grid on
hold off

% affiche Rigidite de d�rive
N=findobj('tag','Rigidite');
axes(N)
hold on
plot(Donnees(:,15),'b')
plot(Donnees(:,16),'r')
plot(Donnees(:,17),'.b')
plot(Donnees(:,18),'.r')
grid on
hold off

% affiche d�rives Globales
N=findobj('tag','DerGlob');
axes(N)
hold on
plot(Donnees(:,21)*180/pi,'k')
plot(Donnees(:,14)*180/pi,'b')
plot(Donnees(:,20)*180/pi,'r')
grid on
hold off

% affiche vitesse
N=findobj('tag','Vitesse');
axes(N)
hold on
plot(Donnees(:,8),Donnees(:,6),'k')
grid on
hold off


