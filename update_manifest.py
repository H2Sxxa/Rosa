import json
import os

from Remilia.log import Logger
from Remilia.res import rFile, rPath
from Remilia.utils.cli import prompts

os.chdir("forgegradle/%s" % prompts.ListPrompt("Target_dir",[prompts.Choice(_,_) for _ in os.listdir("forgegradle") if rPath("forgegradle/%s" % _).is_dir()]).prompt())

logger = Logger()
localls = [pth for pth in os.listdir() if rPath(pth).is_dir()]
for pkg in localls:
    pkgls = os.listdir(pkg)
    pkginfo = json.loads(rFile(pkg + "/package.json").text)
    manifest = pkginfo["manifest"]
    resultmanifest = []
    includels = []
    for entry in pkgls:
        if rPath(entry).to_file().ext == ".class":
            for entry2 in manifest:
                if entry == entry2["name"]:
                    resultmanifest.append(
                        {
                            "name": entry,
                            "location": entry2["location"],
                            "uri": {
                                "blob": "https://github.com/H2Sxxa/Rosa/blob/bin/forgegradle/class/%s/%s"
                                % (pkg, entry),
                                "raw": "https://github.com/H2Sxxa/Rosa/raw/bin/forgegradle/class/%s/%s"
                                % (pkg, entry),
                            },
                        }
                    )
                    includels.append(entry)
            if entry not in includels:
                resultmanifest.append(
                    {
                        "name": entry,
                        "location": "",
                        "uri": {
                            "blob": "https://github.com/H2Sxxa/Rosa/blob/bin/forgegradle/class/%s/%s"
                            % (pkg, entry),
                            "raw": "https://github.com/H2Sxxa/Rosa/raw/bin/forgegradle/class/%s/%s"
                            % (pkg, entry),
                        },
                    }
                )
    pkginfo["manifest"] = resultmanifest
    fin = json.dumps(pkginfo, indent=4)
    rFile(pkg + "/package.json").write(fin)
    logger.info("write to", pkg)
