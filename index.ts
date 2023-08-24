import bindings from "bindings"
const addon = bindings("mac-cursor-effects.node")

const isMac = process.platform === "darwin"
export const shakeCursor = (distance = 2, duration = 0.2, iterations = 4) => {
  if (!isMac) return
  return addon.shakeCursor(distance, duration, iterations)
}
