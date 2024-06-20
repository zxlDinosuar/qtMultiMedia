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
