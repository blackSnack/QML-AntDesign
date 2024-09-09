export function createLazyProxy(target = {}, proxy = null) {
    return new Proxy(target, {
        set(target, prop, value) {
            target[prop] = wrapValueWithProxy(value);

            if (proxy && proxy.target) {
                if (prop in proxy.target) {
                    proxy.target[prop] = target[prop];
                }
            }

            return true;
        },
        get(target, prop) {
            if (prop in target) return target[prop];

            if (proxy.target && (prop in proxy.target)) {
                let value = proxy.target[prop];
                target[prop] = wrapValueWithProxy(value);
                return target[prop];
            }

            return undefined;
        }
    });
}

function wrapValueWithProxy(value) {
    if (value && typeof value === "object") {
        return createLazyProxy(value);
    }
    return value;
}
