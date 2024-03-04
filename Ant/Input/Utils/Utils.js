.pragma library
.import AntCore 1.0 as Core

class AntInputStyleProxy {
    constructor(control, style) {
        this.control = control
        this.style = style


        const proxyStyle = new Proxy(this, {
                                         get: (target, property) => this.handleGet(target, property)
                                     });
        this.statusColorMap = new Map([
                                          ["Default",
                                           {
                                               default: Core.AntTheme.colorText,
                                               default_border: Core.AntTheme.colorBorder,
                                               hovered: proxyStyle.hoverBorderColor,
                                               activeFocus: proxyStyle.activeBorderColor,
                                               disabled: Core.AntTheme.colorBorder,
                                           }
                                          ],
                                          ["Error",
                                           {
                                               default: Core.AntTheme.colorError,
                                               default_border: Core.AntTheme.colorError,
                                               hovered: Core.AntTheme.colorErrorBorderHover,
                                               activeFocus: Core.AntTheme.colorError,
                                               disabled: Core.AntTheme.colorBorder,
                                           }
                                          ],
                                          ["Warning",
                                           {
                                               default: Core.AntTheme.colorWarning,
                                               default_border: Core.AntTheme.colorWarning,
                                               hovered: Core.AntTheme.colorWarningBorderHover,
                                               activeFocus: Core.AntTheme.colorWarning,
                                               disabled: Core.AntTheme.colorBorder,
                                           }
                                          ],
                                          ["Success",
                                           {
                                               default: Core.AntTheme.colorText,
                                               default_border: Core.AntTheme.colorBorder,
                                               hovered: proxyStyle.hoverBorderColor,
                                               activeFocus: proxyStyle.activeBorderColor,
                                               disabled: Core.AntTheme.colorBorder,
                                           }
                                          ]
                                      ]
                                      )
        return proxyStyle
    }

    handleGet(target, property) {
        if (!(property in target)) {
            return target.style[property]
        }

        return target[property];
    }

    currentState(target) {
        if(!target.enabled) return "disabled"
        if(target.content && target.content.activeFocus) return "activeFocus"
        if(target.hovered) return "hovered"
        return "default"
    }

    borderColor(target) {
        let state = this.currentState(target)
        if (state === "default") { state = `${state}_border`}
        return this.statusColorMap.get(this.control.state)[state]
    }

    get prefixColor() {
        if (this.control.state === "Default") { return this.style.textColor }
        return this.statusColorMap.get(this.control.state)[this.currentState(this.control)]
    }

    get controlHeight() {
        switch(this.style.size) {
            case "small": return Core.AntTheme.controlHeightSM
            case "large": return Core.AntTheme.controlHeightLG
            case "middle":
            default: return Core.AntTheme.controlHeight
        }
    }

    get fontSize() {
        switch(this.style.size) {
            case "small": return this.style.inputFontSizeSM
            case "large": return this.style.inputFontSizeLG
            case "middle":
            default: return this.style.inputFontSize
        }
    }

    get horizontalPadding() {
        switch(this.style.size) {
            case "small": return this.style.paddingInlineSM
            case "large": return this.style.paddingInlineLG
            case "middle":
            default: return this.style.paddingInline
        }
    }

    get verticalPadding() {
        switch(this.style.size) {
            case "small": return this.style.paddingBlockSM
            case "large": return this.style.paddingBlockLG
            case "middle":
            default: return this.style.paddingBlock
        }
    }
}
