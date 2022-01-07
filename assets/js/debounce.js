export default function debounce(ms, fn) {
  let timer
  return function () {
    clearTimeout(timer)
    const args = Array.prototype.slice.call(arguments)
    args.unshift(this)
    timer = setTimeout(fn.bind.apply(fn, args), ms)
  }
}