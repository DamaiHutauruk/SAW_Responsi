function varargout = F_123190074(varargin)
% F_123190074 MATLAB code for F_123190074.fig
%      F_123190074, by itself, creates a new F_123190074 or raises the existing
%      singleton*.
%
%      H = F_123190074 returns the handle to a new F_123190074 or the handle to
%      the existing singleton*.
%
%      F_123190074('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in F_123190074.M with the given input arguments.
%
%      F_123190074('Property','Value',...) creates a new F_123190074 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before F_123190074_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to F_123190074_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help F_123190074

% Last Modified by GUIDE v2.5 26-Jun-2021 00:01:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @F_123190074_OpeningFcn, ...
                   'gui_OutputFcn',  @F_123190074_OutputFcn, ...
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


% --- Executes just before F_123190074 is made visible.
function F_123190074_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to F_123190074 (see VARARGIN)

% Choose default command line output for F_123190074
handles.output = hObject;

data = xlsread('DATA RUMAH.xlsx','A2:A21');
data2 = xlsread('DATA RUMAH.xlsx','C2:H21');

data = [data data2];
data = num2cell(data); %mengubah tipe data dari array ke cell untuk dapat ditampilkan di tabel

set(handles.uitable1,'Data',data);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes F_123190074 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = F_123190074_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function uitable1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = xlsread('DATA RUMAH.xlsx','C2:H21'); %mengambil data dari file excel

%nilai atribut, dimana 0= atribut biaya &1= atribut keuntungan
k=[0,1,1,1,1,1];
w=[0.30, 0.20, 0.23, 0.10, 0.07, 0.10];

%normalisasi matriks
[m,n]=size (data); 
R=zeros (m,n);

for j=1:n
    if k(j)==1 %statement kriteria keuntungan
        R(:,j)=data(:,j)./max(data(:,j));
    else
        R(:,j)=min(data(:,j))./data(:,j); %statement kriteria biaya
    end
end

%penjumlahan & perkalian dengan bobot berdasarkan kriteria
for i=1:m
    V(i)= sum(w.*R(i,:));
end

nilai = sort(V,'descend'); %mengurutkan data dari yang terbaik

for i=1:20
    hasil(i) = nilai(i);
end %memilih 20 rumah terbaik

opts2 = detectImportOptions('DATA RUMAH.xlsx');
opts2.SelectedVariableNames = [2];

nama = readmatrix('DATA RUMAH.xlsx',opts2); %mengimpor nama rumah dari file dan menyimpan di var nama

for i=1:20
    for j=1:m
        if(hasil(i) == V(j))
        rekomendasi(i) = nama(j);
        break
        end
    end
end%proses perulangan mencari nama 20 rumah terbaik

rekomendasi = rekomendasi';

set(handles.uitable2,'Data',rekomendasi);
