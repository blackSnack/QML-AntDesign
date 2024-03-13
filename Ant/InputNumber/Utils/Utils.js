.import "qrc:/AntInput/Utils/Utils.js" as Utils

class AntInputNumberStyleProxy extends  Utils.AntInputStyleProxy {

    get handleVisible() {
        if (typeof this.style.handleVisible === "boolean") {
            return this.style.handleVisible
        } else if (typeof this.style.handleVisible === "string" &&
                   this.style.handleVisible === "auto") {
            return this.control.hovered || this.control.actived
        }
        console.warn("Can not parser handleVisible from use input value:", this.style.handleVisible,
                     "Except input boolean | 'auto'")
        return false
    }
}
