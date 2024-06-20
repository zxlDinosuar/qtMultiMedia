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

function formatTime(seconds) {
    var times = Math.floor((seconds / 1000))
    var h = Math.floor(times / 3600);
    var m = Math.floor((times % 3600) / 60);
    var s = Math.floor(times % 60);
    return `${h.toString().padStart(2, '0')}:${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`;
}

function reduceTime(hourEdit, minuteEdit, secondEdit,flag) {

    //arguments[0] == 传递进来的第一个参数
    // 获取当前时间并转换为整数
    var hours = parseInt(hourEdit.text, 10);
    var minutes = parseInt(minuteEdit.text, 10);
    var seconds = parseInt(secondEdit.text, 10);
    // 当前时间为0时，弹出消息对话框并退出函数
    if(hours === 0 && minutes === 0 && seconds === 0) {
        content.dialogs.tipDialoglow.open();
        return; // 退出函数
    }

    var time = hours*3600 + minutes*60 + seconds;

    if(flag === 0){
        time -= 3600
    }else if(flag === 1){
        time -= 60
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
    hourEdit.text = hours.toString().padStart(2, '0');
    minuteEdit.text = minutes.toString().padStart(2, '0');
    secondEdit.text = seconds.toString().padStart(2, '0');
}

function addTime(hourEdit, minuteEdit, secondEdit,flag)
{
    // 获取当前时间并转换为整数
    let hours = parseInt(hourEdit.text, 10);
    console.log("hours:", hours)
    let minutes = parseInt(minuteEdit.text, 10);
     console.log("minutes:", minutes)
    let seconds = parseInt(secondEdit.text, 10);
     console.log("seconds:", seconds)

    // 当前时间为最大时，弹出消息对话框并退出函数
    if(hours === 24 && minutes === 60 && seconds === 60) {
        content.dialogs.tipDialoghigh.open();
        return; // 退出函数
    }
    let time = hours*3600 + minutes*60 + seconds;

    if(flag === 0){
        time += 3600
    }else if(flag === 1){
        time += 60
    }else {
        time += 1
    }
    // hours = time/3600;
    hours = Math.floor(time/3600)
    console.log("hours:", hours)
    minutes = Math.floor((time -hours*3600)/60);
    console.log("minutes:", minutes)
    seconds = Math.floor(time-hours*3600-minutes*60);
    console.log("seconds:", seconds)

    // 更新时间并格式化为两位数
    hourEdit.text = hours.toString().padStart(2, '0');
    minuteEdit.text = minutes.toString().padStart(2, '0');
    secondEdit.text = seconds.toString().padStart(2, '0');

}


