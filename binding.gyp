{
    "targets": [
        {
            "target_name": "mac-cursor-effects",

            "conditions": [
                ['OS=="mac"', {
                    "sources": [ "cursor-effects.mm" ],
                }]
            ],
            'include_dirs': [
                "<!@(node -p \"require('node-addon-api').include\")",
                "<!@(node -p \"require('nan')\")",
                ],
            'libraries': [],
            'dependencies': [
            "<!(node -p \"require('node-addon-api').gyp\")"
            ],
            "xcode_settings": {
                "OTHER_CPLUSPLUSFLAGS" : ["-stdlib=libc++", "-fobjc-arc"],
                "GCC_ENABLE_CPP_EXCEPTIONS": "YES",
                "GCC_ENABLE_CPP_RTTI": "YES",
                "MACOSX_DEPLOYMENT_TARGET": "10.7", 
                "CLANG_CXX_LIBRARY": "libc++",
                "CLANG_CXX_LANGUAGE_STANDARD" : "c++17",
                "GCC_ENABLE_OBJC_ARC" : "YES"
            },
            'cflags!': [ '-fno-exceptions' ],
            'cflags_cc!': [ '-fno-exceptions' ],
            'libraries': [
                '-framework AppKit'
            ],
            'defines': ['NAPI_DISABLE_CPP_EXCEPTIONS']
        }
    ]
}
