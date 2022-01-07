import debounce from './debounce'
import vegaEmbed from "vega-embed"

export default {
  mounted() {
    const container = document.createElement("div");

    this.id = this.el.getAttribute("data-id");
    this.view = null;
    this.el.appendChild(container);

    const vegaLiteInit = async ({ spec }) => {
      const { view } = await vegaEmbed(container, spec, {})
      this.view = view
    }

    this.handleEvent(`vega_lite:${this.id}:init`, vegaLiteInit)

    const handleResize = debounce(500, entries => {
      for (const entry of entries) {
        this.pushEvent("resized", { id: this.id, width: entry.contentRect.width })
      }
    })

    const resizeObserver = new ResizeObserver(handleResize)
    resizeObserver.observe(this.el)
  },

  destroyed() {
    if (this.view) {
      this.view.finalize()
    }
  }
}