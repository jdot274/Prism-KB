# FAQ

## Project setup

**Q: Source UE or Launcher UE?**
A: Launcher for most projects. Source UE if you need Dedicated Server builds, engine modifications, or want to be able to step into engine code.

**Q: Open World template or Third Person template?**
A: Open World if you'll have a large map (World Partition is enabled). Third Person for smaller, traditional levels.

## Rendering

**Q: Should I use Nanite for everything?**
A: For static meshes, yes — Nanite + Lumen is the default modern pipeline. Skeletal Nanite is supported but with caveats. Translucent / masked materials don't benefit.

**Q: Lumen Software RT vs Hardware RT?**
A: HW RT for high-end PC / next-gen consoles where the GPU supports DXR and you want crisp reflections. SW RT for older hardware or where reflections are mostly rough.

**Q: TSR vs DLSS vs FSR?**
A: TSR is built-in and good. DLSS is best on RTX hardware. FSR works on all hardware but lower quality. Use **Streamline SDK** to expose all three in the same project.

## Plugins

**Q: Web Browser vs WebUI?**
A: Web Browser is built-in, free, easy. WebUI is community-maintained but supports render-to-material — drop a three.js scene on any mesh surface.

**Q: Pixel Streaming or hand-rolled WebRTC?**
A: Pixel Streaming. It already handles signalling, encoding, input forwarding, scaling via SFU.

## PCG vs Foliage

**Q: Which should I use?**
A: PCG for procedural rules and re-runnable content. Foliage for hand-curated dressing. They can coexist — PCG can bake to foliage instances.

## Networking

**Q: Replication Graph or Iris?**
A: Both, together. Replication Graph manages relevancy at scale. Iris is the underlying replication system. They're complementary.

**Q: Push Model — should I always use it?**
A: Yes. Order-of-magnitude reduction in CPU for high-actor-count games, with minimal code change.

## AI tooling

**Q: UnrealClaudeMCP or Unreal AI Connection?**
A: UnrealClaudeMCP if you want stability. Unreal AI Connection if you need its bulk asset ops or modding tools.

**Q: CCGS replaces UnrealClaudeMCP?**
A: No. CCGS is the Claude Code workflow / agent layer. UnrealClaudeMCP is the UE editor automation layer. Use them together for full coverage.

## Performance

**Q: How many actors can a level hold?**
A: With World Partition + OFPA, tens of thousands. Without WP, expect editor performance issues over a few thousand.

**Q: Should I make my game C++ or Blueprint?**
A: Systems and hot paths in C++. Gameplay logic, configuration, content assembly in Blueprint. Lyra is the reference balance.

## Multiplayer

**Q: Listen Server or Dedicated Server?**
A: Listen for prototyping and small multiplayer. Dedicated for shipping anything serious — cheating prevention, scalability.

**Q: How do I host?**
A: AWS GameLift / Hathora / Agones / Vagon for managed. Roll your own with Linux + a UE server build for control.

## Cinematics

**Q: Movie Render Queue or Sequencer alone?**
A: Sequencer for authoring. MRQ for rendering — gives you Reference Motion Blur, OIDN denoise, console variable overrides for higher quality than realtime allows.
