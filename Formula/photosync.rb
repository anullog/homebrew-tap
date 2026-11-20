class Photosync < Formula
  desc "Safe copy, mirror and verify for photo folders and memory cards"
  homepage "https://github.com/anullog/photosync"
  url "https://github.com/anullog/photosync/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "b68f1185a8da80857882f73918a7edd5d3c83ef5208f5f43952a43b35a0f52ba"
  license "MIT"

  depends_on :macos

  def install
    bin.install "photo.sh" => "photosync"
  end

  def caveats
    <<~EOS
      photosync works with the rsync built into macOS. For one overall
      progress bar instead of one per file, also install Homebrew's rsync:
        brew install rsync
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/photosync --version")

    (testpath/"card/DCIM").mkpath
    (testpath/"card/DCIM/A.ARW").write "photo"
    system bin/"photosync", "copy", testpath/"card", testpath/"ssd", "-c"
    assert_equal "photo", (testpath/"ssd/DCIM/A.ARW").read

    # nothing is replaced without an answer typed on a terminal
    rm testpath/"card/DCIM/A.ARW" # Pathname#write in Homebrew refuses to overwrite
    (testpath/"card/DCIM/A.ARW").write "another photo"
    shell_output("#{bin}/photosync copy #{testpath}/card #{testpath}/ssd </dev/null 2>&1", 1)
    assert_equal "photo", (testpath/"ssd/DCIM/A.ARW").read
  end
end
