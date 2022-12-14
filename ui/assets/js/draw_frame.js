const drawFrame = function (ctx, data) {
  if (data == null) { return }

  const px = data.length // 24
  const py = data[0].length // 32
  const ps = 20
  const width = px * ps
  const height = py * ps

  let min = Infinity
  let max = -Infinity
  data.forEach(row => {
    row.forEach((pixelTemperature, ci) => {
      if (pixelTemperature < min) { min = pixelTemperature }
      if (pixelTemperature > max) { max = pixelTemperature }
    })
  })

  // The Pimoroni MLX90640 breakout is mounted sidewise
  data.forEach((row, ri) => {
    row.forEach((pixelTemperature, ci) => {
      const h = mapValue(pixelTemperature, min, max, 240, 0)
      // Pixel "x" is the real one, others are interpolated:
      // +---+---+---+
      // |   |   |   |
      // +---+---+---+
      // |   | x |   |
      // +---+---+---+
      // |   |   |   |
      // +---+---+---+
      ctx.fillStyle = `hsla(${h}, 100%, 50%, 25%)`
      ctx.fillRect(ps * ri - ps * 0.5, ps * ci - ps * 0.5, ps * 0.5, ps * 0.5)
      ctx.fillStyle = `hsla(${h}, 100%, 50%, 50%)`
      ctx.fillRect(ps * ri - ps * 0.5, ps * ci, ps * 0.5, ps * 0.5)
      ctx.fillStyle = `hsla(${h}, 100%, 50%, 33%)`
      ctx.fillRect(ps * ri - ps * 0.5, ps * ci + ps * 0.5, ps * 0.5, ps * 0.5)
      ctx.fillStyle = `hsla(${h}, 100%, 50%, 50%)`
      ctx.fillRect(ps * ri, ps * ci - ps * 0.5, ps, ps * 0.5)
      ctx.fillStyle = `hsla(${h}, 100%, 50%, 100%)`
      ctx.fillRect(ps * ri, ps * ci, ps, ps)
    })
  })

  const steps = [0, 1, 2, 3, 4]
  ctx.font = '20px Verdana'
  ctx.fillStyle = 'rgb(0, 0, 0)'
  ctx.fillRect(0, height + 5, width, 40)
  steps.forEach((_, i) => {
    const t = min + (i * (max - min) / (steps.length - 1))
    const h = mapValue(t, min, max, 240, 0)
    ctx.fillStyle = `hsl(${h}, 100%, 50%)`
    ctx.fillText(`${t.toFixed(2)}º`, 20 + i * (width - 20) / steps.length, height + 30)
  })

  if (window.Ui.targetMode && data != null) {
    drawViewfinder(ctx, width, height, ps * 2)
    const a = data[px / 2 - 1][py / 2 - 1]
    const b = data[px / 2 - 1][py / 2]
    const c = data[px / 2][py / 2 - 1]
    const d = data[px / 2][py / 2]
    const avgT = (a + b + c + d) / 4

    ctx.fillStyle = 'rgba(0, 0, 0, 0.7)'
    ctx.fillRect(width / 2 - 40, height / 2 + 35, 80, 35)
    ctx.fillStyle = 'rgb(240, 240, 240)'
    ctx.fillText(`${avgT.toFixed(2)}º`, width / 2 - 35, height / 2 + ps * 3)
  }
}

const mapValue = function (value, fromMin, fromMax, toMin, toMax) {
  const fraction = (value - fromMin) / (fromMax - fromMin)
  return (fraction * (toMax - toMin) + toMin).toFixed(0)
}

const drawViewfinder = function (ctx, width, height, size) {
  ctx.lineWidth = 2
  ctx.strokeStyle = 'rgb(9, 9, 9)'

  ctx.strokeRect(width / 2 - size / 2, height / 2 - size / 2, size, size)

  ctx.beginPath()
  ctx.moveTo(width / 2 - size / 2 - 5, height / 2)
  ctx.lineTo(width / 2 - size / 2 + 5, height / 2)
  ctx.stroke()

  ctx.beginPath()
  ctx.moveTo(width / 2 + size / 2 - 5, height / 2)
  ctx.lineTo(width / 2 + size / 2 + 5, height / 2)
  ctx.stroke()

  ctx.beginPath()
  ctx.moveTo(width / 2, height / 2 - size / 2 - 5)
  ctx.lineTo(width / 2, height / 2 - size / 2 + 5)
  ctx.stroke()

  ctx.beginPath()
  ctx.moveTo(width / 2, height / 2 + size / 2 - 5)
  ctx.lineTo(width / 2, height / 2 + size / 2 + 5)
  ctx.stroke()

  ctx.lineWidth = 1
}

export default drawFrame
