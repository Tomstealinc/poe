#  0.4.0
- Fixed sizing of `IntroViewController`'s "Use a Bridge" and "Continue Without" buttons
  for languages where translation is rather long.
- Updated existing and added more languages (partly stubs only): Breton, Greek, Gujarati, 
  Hebrew, Indonesian, Italian, Macedonian, Polish, Romanian, Turkish, Vietnamese
- Updated to Swift 4.2.
- Updated dependencies.

# 0.4.1
- Adapted to changed signature of `AVCaptureMetadataOutputObjectsDelegate` callback method.

# 0.4.2
- Allow an explicit delegate on `BridgeSelectViewController` to support situations, 
  where the presentingViewController and the callback delegate are not the same.
