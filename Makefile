export SITE := $(PWD)
DIST = $(SITE)/dist
BUILD = $(SITE)/build

SECTIONS = $(shell cat $(SITE)/sections)

.PHONY: build clean

generate: $(addprefix $(DIST)/,swagga.css swaggy.js index.xhtml)

cleanall : clean
	rm -rf $(DIST)
clean :
	rm -rf $(BUILD)

$(BUILD) :
	mkdir $@
$(DIST) :
	mkdir $@
$(DIST)/audio/ : | $(DIST)
	mkdir $@

$(DIST)/% : % | $(DIST)
	cp -u -t $(DIST) $<
$(DIST)/% : $(SITE)/% | $(DIST)
	cp -u -t $(DIST) $<

$(BUILD)/%.sect : $(addprefix $(SITE)/,%/title %/lines dist/audio/%.mp3 dist/audio/%.webm) | $(BUILD)
	./mk_section $* > $@
$(BUILD)/%.sect : $(SITE)/%/custom | $(BUILD)
	cp -u $< $@

$(DIST)/index.xhtml : $(addprefix $(BUILD)/, $(addsuffix .sect, $(SECTIONS))) | $(DIST)
	./mk_html $(SECTIONS) > $@

$(DIST)/swagga.scss : $(addprefix $(SITE)/,$(addsuffix /pos, $(SECTIONS)) $(addsuffix /color, $(SECTIONS))) | $(DIST)
	./mk_css $(SECTIONS) > $@

%.css : %.scss
	scss $< $@

$(DIST)/audio/%.mp3 : $(SITE)/%/audio.wav | $(DIST)/audio/
	ffmpeg -i $< $@ </dev/null >/dev/null 2>/dev/null
$(DIST)/audio/%.webm : $(SITE)/%/audio.wav | $(DIST)/audio/
	ffmpeg -i $< $@ </dev/null >/dev/null 2>/dev/null

.PRECIOUS : %.wav
.PRECIOUS : $(DIST)/audio/%.mp3
.PRECIOUS : $(DIST)/audio/%.webm
%/audio.wav : %/transcript.txt
	$(error You must record $@ again as transcript $< has changed)
