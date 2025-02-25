
# Unreal Xist Tools

Xist's Unreal C++ Build & Dev Tools.  Requires PowerShell 7+.

Main Branch: https://github.com/XistGG/UnrealXistTools/


## Setup

- Make sure you are using PowerShell 7+
  - `winget install Microsoft.PowerShell`
- Clone this repository
- Add this repository clone folder to your `$env:PATH`


# Build Tools

- [UProjectClean.ps1](#uprojectcleanps1)
  - Completely Clean/Reset Repo/Depot
  - Removes all generated C++ Build files
  - Regenerate Project Files
- [UEdit.ps1](#ueditps1)
  - Edit a project in Unreal Editor
- [UnrealVersionSelector.ps1](#unrealversionselectorps1)
  - Easy-to-use interface to Epic's UnrealVersionSelector.exe


# IDE Tools

- [Rider.ps1](#riderps1)
  - Edit a project in Rider
- [VS.ps1](#vsps1)
  - Edit a project in Visual Studio


# Engine Tools

- [MigrateUEMarketplacePlugin.ps1](#migrateuemarketplacepluginps1)
  - Migrate a C++ plugin from one Engine version to another
- [UEngine.ps1](#uengineps1)
  - View and Modify Custom Engine Builds *(read/write Epic's Windows registry keys)*


# Project Tools

- [CreateCleanLyraUProject.ps1](#createcleanlyrauprojectps1)
  - Setup Default Lyra Project on Git
- [UProject.ps1](#uprojectps1)
  - Get Project Settings
- [UProjectFile.ps1](#uprojectfileps1)
  - Get the `.uproject` file associated with a path (current directory by default)
- [UProjectSln.ps1](#uprojectslnps1)
  - Get the `.sln` file associated with a path (current directory by default)


# P4 Tools

- [P4EncodePath.ps1](#p4encodepathps1)
  - Encode (or `-Decode`) paths for P4
- [P4ImportBulk.ps1](#p4importbulkps1)
  - Import a massive number of files into a new depot without breaking P4
    (tested by importing 800k+ files from UDN P4 `//UE5/Release-5.2`)
- [P4Info.ps1](#p4infops1)
  - Makes it real easy to extract `p4 info` values


--------------------------------------------------------------------------------


# CreateCleanLyraUProject.ps1

[view source: UProjectClean.ps1](https://github.com/XistGG/UnrealXistTools/blob/main/CreateCleanLyraUProject.ps1)   
[more information: How to Create a Lyra-based Project in Git](https://x157.github.io/UE5/LyraStarterGame/Tutorials/How-to-Create-a-Lyra-Repo.html)

- Clones Lyra From Epic Source Github
- Copies Lyra Content From Epic Launcher
- Setups default branches
  - `lyra-main`
  - `lyra-api`
  - `lyra-game`

### Usage Examples
#### Parameters:
- `-EngineRepositoryUrl` (optional, default: "https://github.com/EpicGames/UnrealEngine") 
  - URL of the Unreal Engine repository.
- `-EngineBranch` (optional, default: "5.2") 
  - Branch of the Unreal Engine to use.
- `-WorkspaceDir` (required): 
  - Directory where your project will be created.
- `-UE5Root` (required): 
  - Directory where Unreal Engine is located.
- `-LyraContentDir` (required): 
  - Directory containing the Lyra content.
- `-LyraMainBranch` (optional, default: "lyra-main"): 
  - Name of the main Lyra branch.
- `-LyraApiBranch` (optional, default: "lyra-api"): 
  - Name of the Lyra API branch.
- `-GameBranch` (optional, default: "lyra-game"): 
  - Name of the game branch.
- `-GameName` (optional, default: "Lyra"): 
  - Name of your game project.

Generate a default clean lyra project on UE5.2
```powershell
CreateCleanLyraUProject.ps1 -GameName "MyGame" -WorkspaceDir "\\Projects\MyGame" -UE5Root "\\UnrealEngineSource" -LyraContentDir "\\LyraContent"
```

# UProjectClean.ps1

[view source: UProjectClean.ps1](https://github.com/XistGG/UnrealXistTools/blob/main/UProjectClean.ps1)

- Delete all `Binaries` (generated data)
- Delete all `Intermediate` (generated data)
- Delete all `*.sln` (generated data)
- Delete all `.idea` (if you set `-Idea` switch)
- Delete all `DerivedDataCache` (if you set `-DDC` switch)
- Generate Project Files

Supports the `-Debug` flag, add it to any command to gain more insight.

### Usage Examples

Clean the project in the current directory:
```powershell
UProjectClean.ps1
```

Clean a specific `MyGame.uproject`:
```powershell
UProjectClean.ps1 MyGame.uproject
```


# UEdit.ps1

[view source: UEdit.ps1](https://github.com/XistGG/UnrealXistTools/blob/main/UEdit.ps1)

Start Unreal Editor: Open the `.uproject` associated with the current directory.

Alias for `UnrealVersionSelector.ps1 -Editor $(&UProjectFile.ps1 -Path:$Path).FullName`

Note that as this uses `UnrealVersionSelector` under the hood, you must have compiled your
editor and project in `Development Editor` mode.  When opening a project in editor, the
underlying UVS requires that we use a Development editor.

Supports the `-Debug` flag, add it to any command to gain more insight.


### Usage Examples

Open the `.uproject` file in the current directory:
```powershell
UEdit.ps1
```

Open the `.uproject` file in the specified directory:
```powershell
UEdit.ps1 path/to/project
```


# UnrealVersionSelector.ps1

[view source: UnrealVersionSelector.ps1](https://github.com/XistGG/UnrealXistTools/blob/main/UnrealVersionSelector.ps1)

- Allows developer to refer to `.uproject` files via relative paths
- Infers the name of `.uproject` files based on current directory
- Executes Epic's `UnrealVersionSelector.exe` for base functionality

Supports the `-Debug` flag, add it to any command to gain more insight.

See `-Help` for Usage.

### Usage Examples

Generate project files:
```powershell
UnrealVersionSelector.ps1 -ProjectFiles
```

Choose which Engine to use:
```powershell
UnrealVersionSelector.ps1 -SwitchVersion
```

Choose a Specific Engine:
```powershell
UnrealVersionSelector.ps1 -SwitchVersionSilent /Project/Root/Engine/Binaries/../..
```


--------------------------------------------------------------------------------


# Rider.ps1

[view source: Rider.ps1](https://github.com/XistGG/UnrealXistTools/blob/main/Rider.ps1)

Start Rider: Open the `.uproject` associated with the current directory.

Supports the `-Debug` flag, add it to any command to gain more insight.

### Usage Examples

Open the `.uproject` file in the current directory:
```powershell
Rider.ps1
```

Open the `.sln` file in the current directory:
```powershell
Rider.ps1 -sln
```


# VS.ps1

[view source: VS.ps1](https://github.com/XistGG/UnrealXistTools/blob/main/VS.ps1)

Start Visual Studio: Open the `.sln` associated with the current directory.

Supports the `-Debug` flag, add it to any command to gain more insight.

### Usage Examples

Open the `.sln` file in the current directory:
```powershell
VS.ps1
```

Diff 2 files (for example can be used from `p4v` as the diff tool)
```powershell
VS.ps1 -diff file1 file2
```


--------------------------------------------------------------------------------


# MigrateUEMarketplacePlugin.ps1

[view source: MigrateUEMarketplacePlugin.ps1](https://github.com/XistGG/UnrealXistTools/blob/main/MigrateUEMarketplacePlugin.ps1)

Required Arguments:

- `-Plugin` Name
- `-From` PathToSourceEngineRoot
- `-To` PathToDestinationEngineRoot

Optional Arguments:

- `-ToThirdParty`
  - If present, causes the plugin to be migrated to your `Plugins/ThirdParty` directory rather
    than to the default `Plugins/Marketplace`
- `-Debug`
  - If present, this switch causes additional debugging output to be written
- `-Force`
  - If the destination plugin already exists, forcefully remove it and overwrite with the newly built plugin
  - If this switch is not present, the script will abort rather than overwrite an existing plugin

### Usage Examples

```powershell
MigrateUEMarketplacePlugin.ps1 -Plugin AutoSizeComments -From "E:/EpicLauncher/UE_5.1" -To "E:/MyEngine_5.2" -Debug -Force
MigrateUEMarketplacePlugin.ps1 -Plugin BlueprintAssist -From "E:/EpicLauncher/UE_5.1" -To "E:/MyEngine_5.2" -Debug -Force
MigrateUEMarketplacePlugin.ps1 -Plugin VisualStudioTools -From "E:/EpicLauncher/UE_5.1" -To "E:/MyEngine_5.2" -Debug -Force
```

In the above example, you would have told the Epic Games Launcher to install UE 5.1 into
the folder `E:/EpicLauncher/UE_5.1`
and you would have installed these plugins from the UE Marketplace into the UE 5.1 Engine.

These commands would then copy 3 plugins from the UE Marketplace into your custom engine
at `E:/MyEngine_5.2`
including `AutoSizeComments`, `BlueprintAssist` and `VisualStudioTools`.


# UEngine.ps1

[view source: UEngine.ps1](https://github.com/XistGG/UnrealXistTools/blob/main/UEngine.ps1)

- By default selects the engine used by the current or named project
- `-List` lists all available custom engines
- `-Name` selects from available custom engines
- `-NewName` renames an engine to your choice of names
- `-UProject` selects the engine associated with the given .uproject
- `-Start` starts the engine editor (Win64 only)

See `-Help` for more Usage info.

### Usage Examples

Display a list of all custom engines on this system:
```powershell
UEngine.ps1 -List
```

Rename the `OldRandomGUIDName` custom engine as `MyEngine`
```powershell
UEngine.ps1 OldRandomGUIDName -NewName MyEngine
```


--------------------------------------------------------------------------------


# UProject.ps1

[view source: UProject.ps1](https://github.com/XistGG/UnrealXistTools/blob/main/UProject.ps1)

Returns JSON parsed contents of `$UProjectFile` as a PowerShell Object

Supports the `-Debug` flag, add it to any command to gain more insight.

### Usage

View the current `.uproject` in terminal:
```powershell
UProject.ps1
```

Get the Engine Association of a specific `.uproject`:
```powershell
$(UProject.ps1 project.uproject).EngineAssociation
```


# UProjectFile.ps1

[view source: UProjectFile.ps1](https://github.com/XistGG/UnrealXistTools/blob/main/UProjectFile.ps1)

Returns the `.uproject` file relevant to the `-Path`
(implicit first string parameter, or current directory by default).

Example: `/project/project.uproject`

Supports the `-Debug` switch.
Enable it to see debug info to help you understand how the `.uproject` is being assigned.

### Usage

Select the default `.uproject` for the current directory:
```powershell
UProjectFile.ps1
```

Select the default `.uproject` in the specified directory:
```powershell
UProjectFile.ps1 /project
```

Select a specific `.uproject`:
```powershell
UProjectFile.ps1 project.uproject
```


# UProjectSln.ps1

[view source: UProjectSln.ps1](https://github.com/XistGG/UnrealXistTools/blob/main/UProjectSln.ps1)

Returns the `.sln` file relevant to the `-Path`
(implicit first string parameter, or current directory by default).

Example: `/project/project.sln`

Supports the `-Debug` switch.
Enable it to see debug info to help you understand how the `.sln` is being assigned.

### Usage

Select the default `.sln` for the current directory:
```powershell
UProjectSln.ps1
```

Select the default `.sln` in the specified directory:
```powershell
UProjectSln.ps1 /project
```

Select a specific `.sln`:
```powershell
UProjectSln.ps1 project.sln
```


--------------------------------------------------------------------------------


# P4EncodePath.ps1

[view source: P4EncodePath.ps1](https://github.com/XistGG/UnrealXistTools/blob/main/P4EncodePath.ps1)

Encodes or Decodes a P4 path.  See `-Help` for more details.

See [P4 filespecs](https://www.perforce.com/manuals/cmdref/Content/CmdRef/filespecs.html)
for more info regarding P4 path encoding requirements.

See `-Help` for Usage.


# P4ImportBulk.ps1

[view source: P4ImportBulk.ps1](https://github.com/XistGG/UnrealXistTools/blob/main/P4ImportBulk.ps1)

Import a massive number of files into a new depot without breaking P4.

As of Jan-2023 I am unable to get P4 to successfully import UDN in one commit.
Perhaps it is related to RAM availability?

With this script, I can break the 800k+ files into batches and submit those,
which works great.

Supports the `-Debug` flag, add it to any command to gain more insight.

See `-Help` for Usage.


# P4Info.ps1

[view source: P4Info.ps1](https://github.com/XistGG/UnrealXistTools/blob/main/P4Info.ps1)

Extracts `p4 info` output into a Dictionary, which it returns as the result.

You can then grab specific keys if you want, for example:

```powershell
$P4Username = (P4Info.ps1)."User name"
```

You can also use this to initialize `.p4config` files like:

```powershell
P4Info.ps1 -Config > .p4config
```

Try the `-Debug` switch to see the parse info.

