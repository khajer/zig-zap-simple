- instruction
``` sh
$ mkdir zig-zap-simple && cd zig-zap-simple
$ zig init
$ git init      
```

- install dependencies
```sh
$ zig fetch --save "git+https://github.com/zigzap/zap#v0.9.1"
```

- insert code build (build.zig)
```
    // build function
    const zap = b.dependency("zap", .{
        .target = target,
        .optimize = optimize,
        .openssl = false, // set to true to enable TLS support
    });

    exe.root_module.addImport("zap", zap.module("zap"));
```

- build & run 
```
$ zig build
$ zig build run
```