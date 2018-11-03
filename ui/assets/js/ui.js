
const takePicture = function () {
  const canvas = document.getElementById('camera')
  const dataURL = canvas.toDataURL('image/png', 1.0)
  const a = document.createElement('a')
  a.href = dataURL
  // iOS does not support the download attribute
  if (navigator && navigator.platform && /iPad|iPhone|iPod/.test(navigator.platform)) {
    a.target = '_blank'
  } else {
    a.download = `thermacam-image-${(new Date()).valueOf()}.png`
  }
  document.body.appendChild(a)
  a.click()
  document.body.removeChild(a)
}

document.getElementById('takePicture').addEventListener('click', takePicture)

const toggleMeasureMode = function () {
  this.classList.toggle('active')
  window.Ui.targetMode = this.classList.contains('active')
}

document.getElementById('toggleMeasureMode').addEventListener('click', toggleMeasureMode)
