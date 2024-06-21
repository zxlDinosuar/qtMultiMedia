function setFilesModel(selectedFiles){
    for(var i = 0; i < selectedFiles.length; i++){
        var filePath = selectedFiles[i]
        var data = {
            "filePath": filePath
        };
        filesModel.append(data);
    }
    videoList.currentIndex = 0;//currentIndex equals to -1 default,so it must be set to  0
}

function setmergefilesModel(){
    console.log(arguments[0])
    var data={
        "mergefilePath":arguments[0]
    };
    arguments[1].append(data);
    arguments[2].currentIndex=0;
}

function formatTime(seconds) {
    var times = Math.floor((seconds / 1000))
    var h = Math.floor(times / 3600);
    var m = Math.floor((times % 3600) / 60);
    var s = Math.floor(times % 60);
    return `${h.toString().padStart(2, '0')}:${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`;
}

function setmergefilesModel(){
    console.log(arguments[0])
    var data={
        "mergefilePath":arguments[0]
    };
    arguments[1].append(data);
    arguments[2].currentIndex=0;
}

function addtoVideoList(){
    var data={
        "filePath":"file:///"+arguments[0]
    };
    arguments[1].append(data);
}

function exit_singleView(){
    singlePic.visible = false;
}

function reduceTime() {

    //arguments[0] === hourEdit
    //arguments[1] === minuteEdit
    //arguments[2] === secondEdit
    //arguments[3] === flags
    // 获取当前时间并转换为整数
    var hours = parseInt(arguments[0].text, 10);
    var minutes = parseInt(arguments[1].text, 10);
    var seconds = parseInt(arguments[2].text, 10);
    // 当前时间为0时，弹出消息对话框并退出函数
    if(hours === 0 && minutes === 0 && seconds === 0) {
        contents.dialogs.tipDialoglow.open();
        return; // 退出函数
    }
    var time = hours*3600 + minutes*60 + seconds;

    if(arguments[3] === 0){
        if(hours===0)
        {
            contents.dialogs.tipDialoglowhours.open();
        }
        else{
            time -= 3600
        }
    }else if(arguments[3] === 1){
        if(minutes===0&&hours===0)
        {
            contents.dialogs.tipDialoglowminutes.open();
        }
        else{time -= 60}
    }else {
        time -= 1
    }
    hours = Math.floor(time/3600)
    console.log("hours:", hours)
    minutes = Math.floor((time -hours*3600)/60);
    console.log("minutes:", minutes)
    seconds = Math.floor(time-hours*3600-minutes*60);
    console.log("seconds:", seconds)

    // 更新时间并格式化为两位数
    arguments[0].text = hours.toString().padStart(2, '0');
    arguments[1].text = minutes.toString().padStart(2, '0');
    arguments[2].text = seconds.toString().padStart(2, '0');
}

function addTime() {

    //arguments[0] === hourEdit
    //arguments[1] === minuteEdit
    //arguments[2] === secondEdit
    //arguments[3] === flags
    // 获取当前时间并转换为整数
    var hours = parseInt(arguments[0].text, 10);
    var minutes = parseInt(arguments[1].text, 10);
    var seconds = parseInt(arguments[2].text, 10);
    var maxtime=24*3600
    var time = hours*3600 + minutes*60 + seconds;

    if(time===maxtime) {
        contents.dialogs.tipDialoghigh.open();
        return; // 退出函数
    }

    if(arguments[3] === 0){
        time += 3600
    }else if(arguments[3] === 1){
            time += 60
    }else {
        time += 1
    }
    if(time>maxtime)
    {
        contents.dialogs.tipDialoghigh.open();
        return; // 退出函数
    }

    hours = Math.floor(time/3600)
    console.log("hours:", hours)
    minutes = Math.floor((time -hours*3600)/60);
    console.log("minutes:", minutes)
    seconds = Math.floor(time-hours*3600-minutes*60);
    console.log("seconds:", seconds)

    // 更新时间并格式化为两位数
    arguments[0].text = hours.toString().padStart(2, '0');
    arguments[1].text = minutes.toString().padStart(2, '0');
    arguments[2].text = seconds.toString().padStart(2, '0');
}
function setFileModel(){
    // 清理数据模型相当于清理了原来存储的路径
    video_fileModel.clear()
    for(let i=0;i<arguments[0].length;i++){
        let data={"filePath":arguments[0][i]}
        // 将数据成员加入到模块之中
        console.log(arguments[0][i])
        video_fileModel.append(data)

    }
    multiPics.model=video_fileModel
    multiPics.currentIndex=0
}
function singleView(){
   singlePic.visible = true;
   singlePic.z = 1;
  singlePic.focus=true;
    console.log("in singleview")
    console.log(multiPics.currentIndex)
    console.log(singlePic.source)
    console.log(multiPics.currentItem.source)
}


