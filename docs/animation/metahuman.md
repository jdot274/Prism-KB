# MetaHuman

Epic's high-fidelity character system. Three components:

| Tool | Purpose |
| --- | --- |
| **MetaHuman Creator** (cloud) | Author MetaHumans in browser |
| **MetaHuman SDK** | Import + manage MetaHumans in UE |
| **MetaHuman Animator** | Facial mocap from iPhone footage |

## Quick start

1. Sign into Epic Games
2. Open MetaHuman Creator at https://metahuman.unrealengine.com
3. Build a character
4. In Quixel Bridge inside UE → Sign in → MetaHumans tab → Download → drag to scene

## Project setup

Enable:

- **MetaHuman SDK**
- **Live Link** (for face capture)
- **Apple ARKit** (Live Link Face source on iOS)
- **Groom** (for hair / fur — required for MetaHuman hair)

## Tech under the hood

- **Skeleton:** UE5 Mannequin-derived; full body + face control rig
- **Face:** ~100 joints, blendshape-driven via FACS
- **Hair:** Groom system — strands rendered via Niagara or Hair Strands
- **Skin shader:** custom subsurface scattering material with profile asset

## Animation

| Source | How |
| --- | --- |
| Body | Standard skeletal anim, IK Rig retarget from UE Mannequin |
| Face | Live Link Face (iPhone TrueDepth) or MetaHuman Animator (iPhone footage) |
| Lip sync | MetaHuman Animator computes phonemes from audio |

## MetaHuman Animator workflow

1. Record on iPhone using the **Live Link Face** app — exports `.mov` + headcam audio
2. Import into UE — MetaHuman Animator processes:
   - Identity solve (matches your MetaHuman to the actor)
   - Performance solve (FACS curves per frame)
3. Output is a `UAnimSequence` driving the face rig

## Performance

- High-fidelity MetaHumans are expensive — budget 3–8 ms per character at LOD0.
- Use **LOD bias** on the SkeletalMesh and **Groom LOD** for hair.
- For crowds, **MetaHuman Optimizer** (community plugin) reduces them to dramatic-LOD chars.

## Gotchas

- The **Groom system** needs DX12 and a recent GPU. Mobile = no Groom.
- Lighting MetaHumans correctly requires **scattering-aware lighting** — Lumen handles this; baked lighting struggles.
- The **face rig** depends on Live Link Face's data shape — custom face mocap pipelines need conversion.

## See also

- [Control Rig](control-rig.md)
- [UE — MetaHuman docs](https://docs.metahuman.unrealengine.com/)
