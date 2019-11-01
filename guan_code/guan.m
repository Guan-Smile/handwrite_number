function varargout = guan(varargin)
% GUAN MATLAB code for guan.fig
%      GUAN, by itself, creates a new GUAN or raises the existing
%      singleton*.
%
%      H = GUAN returns the handle to a new GUAN or the handle to
%      the existing singleton*.
%
%      GUAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUAN.M with the given input arguments.
%
%      GUAN('Property','Value',...) creates a new GUAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guan_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guan_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guan

% Last Modified by GUIDE v2.5 01-Nov-2019 10:15:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guan_OpeningFcn, ...
                   'gui_OutputFcn',  @guan_OutputFcn, ...
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


% --- Executes just before guan is made visible.
function guan_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guan (see VARARGIN)

% Choose default command line output for guan
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guan wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guan_OutputFcn(hObject, eventdata, handles) 
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
%       See ISPC and COMPUTER.
cla(handles.axes1);
set(handles.edit3,'string','');
%重置画笔标志
global flgim;
flgim = 1;  %可以使用画笔操作


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

global flg style color im flgim;   %flg代表画笔标志，flgim代表画笔标志，mark和rgb代表线形和颜色
flg = 0;  %初始情况下鼠标没有按下
style = '-';  %初始情况下为线性
color = [0,0,0];  %初始情况下为黑色
im = [];   %储存图像
flgim = 1;  %画图笔启用标识符


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global flg x0 y0 x y style color flgim;
flg = 1;
if flg&&flgim
axes(handles.axes1)
position = get(gca,'CurrentPoint');
x = position(1,1);
y = position(1,2);
line(x,y,'LineStyle',style,'color',color,'linewidth',8);
x0 = x;
y0 = y;
end

% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles    structure with handles and user data (see GUIDATA)
global flg;
flg = 0;  %鼠标抬起

% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global flg x0 y0 x y style color flgim;
if flg&&flgim
    x0 = x;
    y0 = y;
    position= get(gca,'CurrentPoint');
    x = position(1,1);
    y = position(1,2);
    line([x0 x],[y0 y],'LineStyle',style,'color',color,'linewidth',5);
end
    


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles) %%提取特征
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im flgim feature
global long   %%设置特征大小
long =14;
set(handles.axes1,'visible','off');
str= getframe(handles.axes1);
set(handles.axes1,'visible','on');
imwrite(str.cdata,'untitled.bmp','bmp');
im = imread('untitled.bmp');
im =rgb2gray(im);
im = im2bw(im);
imwrite(im,'untitled.bmp');
im = imread('untitled.bmp');   %重新获得im
feature = Getfeature_g(im,long);
str=[];
xx=['□','□','□','□','□','□';'□','□','□','□','□','□';'□','□','□','□','□','□';'□','□','□','□','□','□';'□','□','□','□','□','□';'□','□','□','□','□','□'];
set(handles.edit3,'string',xx);
    for i = 0:(long-1)
        for j=0:(long-1)
        if feature(i*long+j+1)>0.1
           str_tem='■';
        else
           str_tem='□';
        end
         str = [str str_tem];
        end
    str = [str 10];

    end
    set(handles.edit3,'string',str);
   
%屏蔽画笔
flgim = 0;  %禁止画笔操作
save ('feature.dat','feature');%保存待检测样本的特征



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)%%载入数据集
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global long
directory = uigetdir('','选择指定文件夹：');%弹出对话框手动指定文件夹
num = 10;%载入样本个数
train =zeros(num,long^2);
for i = 1:num
filepath = fullfile(directory,['Testimage_' num2str(i,'%d') '.bmp']);
fid = imread(filepath);%打开文件
train(i,:)= Getfeature_g_train(fid,long);
end
train


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)%%数字识别
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% 最小错误概率的Bayes方法
% --------------------------------------------------------------------
global feature
load('samplelib.mat');
x = zeros(1,36);    %待测样品
xmeans = zeros(1,36);   %样品的均值
 S = zeros(36,36);   %协方差矩阵
S_ =zeros(36,36);   %S的逆矩阵
pw = zeros(1,10);    %先验概率P(wj)=n(i)/N
hx = zeros(1,10);   %判别函数
t = zeros(1,36);
mode = [];
N = 0;
% 求先验概率
for i = 1:10
    N = pattern(i).num;  %样品总数
end
for i = 1:10
    pw(i) = pattern(i).num/N;
end
%求样品平均值
for n = 1:10  %数字类1-10
    pnum = pattern(n).num;%每一类中的样本个数
    for k = 1:pnum
        for i = 1:36
            if pattern(n).feature(k,i)>0.1   %设置的阈值为0.1，0为格子内完全没有输入
                xmeans(i) = xmeans(i)+1;
            else
                xmeans(i) = xmeans(i)+0;
            end
        end
    end
    for i = 1:36
        xmeans(i) = xmeans(i)/pnum;
    end
    %求协方差
    for i = 1:pnum
        for j = 1:36
            if pattern(n).feature(i,j)>0.1
                mode(i,j) = 1.04;
            else
                mode(i,j) = 0;
            end
        end
    end
    for i = 1:36
        for j = 1:36
            s = 0;
            for k = 1:pnum
                s = s+(mode(k,i)-xmeans(i))*(mode(k,j)-xmeans(j)); 
            end
            s = s/(pnum - 1);
            S(i,j) = s;
        end
    end
    %求S的逆矩阵
    S_ = pinv(S);   %求逆函数pinv
    dets = det(S);  %求行列式的值，函数det
    % 求判别函数
    for i = 1:36
        if feature(i)>0.1
            x(i) = 1;
        else
            x(i) = 0;
        end
    end
    for i = 1:36
        x(i) = x(i) - xmeans(i);
    end
    t = x*S_;
    t1 = t*x';
    t2 = log(pw(n));
    t3 = log(dets+1);
    hx(n) = -t1/2+t2-t3/2;
end
[tem,num] = max(hx);    %找到其中的最大值
num = num-1;

str = num2str(num);
str = ['应用最小错误率的Bayes方法识别结果：' str];
msgbox(str,'结果：');



% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)%%上传图片
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes on button press in pushbutton1.
[filename,pathname] = uigetfile({'*.*';'*.jpg';'*.bmp';'*.gif';'*.png';'*.tif'},'Read Pic');
str = [pathname filename];
global src_img;
if ~isequal([pathname,filename],[0,0])
    src_img = imread(str);
    axes(handles.axes1);
    imshow(src_img);
end
