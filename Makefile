# Zip Naming
NAME ?= Salsa-Kernel
CODENAME ?= Redwood
VERSION ?= v4.0
CUSTOM ?= $(shell date "+%H%M")

ZIP := $(NAME)-$(CODENAME)$(VERSION)-$(CUSTOM)
EXCLUDE := Makefile *.git* *.jar* *placeholder* *.md*

#zipping
zip: $(ZIP)
$(ZIP):
	@echo "Creating ZIP: $(ZIP)-signed.zip"
	@zip -r9 "$@.zip" . -q -x $(EXCLUDE)
	@echo "Signing zip with aosp keys..."
	@java -jar *.jar* "$@.zip" "$@-signed.zip"
	@echo "Done!"

#cleaning
clean:
	@rm -rf modules/vendor/lib/modules/modules.{alias,dep,softdep,load}
	@rm -rf modules/vendor/lib/modules/*.ko
	@rm -rf vendor_ramdisk/lib/modules/*.ko
	@rm -rf dtbo.img
	@rm -rf *dtb*
	@rm -rf Image
	@rm -rf *.zip*
	@echo "Cleaned Up."
