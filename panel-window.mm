#include <napi.h>
#include <ApplicationServices/ApplicationServices.h>

Napi::Value ShakeCursor(const Napi::CallbackInfo& info) {
  Napi::Env env = info.Env();

  if (info.Length() < 2 || !info[0].IsNumber() || !info[1].IsNumber()) {
    Napi::TypeError::New(env, "Wrong number or type of arguments").ThrowAsJavaScriptException();
    return env.Null();
  }

  double distance = info[0].As<Napi::Number>().DoubleValue();
  double duration = info[1].As<Napi::Number>().DoubleValue();
  double iterations = info[2].As<Napi::Number>().DoubleValue();

  CGPoint originalLocation = CGEventGetLocation(CGEventCreate(NULL));

  double sleepDuration = duration / iterations; // Time to sleep in seconds

  for (int i = 0; i < iterations; i++) {
    CGPoint newLocation = originalLocation;
    newLocation.x += (i % 2 == 0) ? distance : -distance; // Alternate shaking left and right
    CGWarpMouseCursorPosition(newLocation);
    usleep(sleepDuration * 1000000); // Sleep for the specified duration
  }

  CGWarpMouseCursorPosition(originalLocation); // Restore original cursor position

  return Napi::Boolean::New(env, true);
}

Napi::Object Init(Napi::Env env, Napi::Object exports) {
  exports.Set(Napi::String::New(env, "shakeCursor"), Napi::Function::New(env, ShakeCursor));
  return exports;
}

NODE_API_MODULE(addon, Init)
