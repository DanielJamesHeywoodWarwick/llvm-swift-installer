import ArgumentParser
import SystemPackage

@main
struct InstallerCommand: ParsableCommand {
    
    func run() throws {
        do {
            let descriptor = try FileDescriptor.open(
                "/opt/homebrew/lib/pkgconfig/llvm.pc",
                .writeOnly,
                options: [.create, .truncate],
                permissions: [.ownerRead, .groupRead, .otherRead]
            )
            try descriptor.closeAfter {
                _ = try descriptor.writeAll(
                    """
                    Name: llvm
                    Description: LLVM for llvm-swift
                    Version: 22.1.8_2
                    Cflags: -I/opt/homebrew/Cellar/llvm/22.1.8_2/include
                    Libs: -L/opt/homebrew/Cellar/llvm/22.1.8_2/lib -lLLVM-22
                    """.utf8
                )
            }
        } catch {
            throw StringError("Failed to create 'llvm.pc': \(error)")
        }
    }
    
    static var configuration: CommandConfiguration {
        CommandConfiguration(
            commandName: "llvm-swift-installer",
            abstract: "Installer for llvm-swift on macOS.",
            version: "1.0.0",
            helpNames: .long
        )
    }
}

struct StringError: Error, CustomStringConvertible {
    
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
    
    var description: String { message }
}
