;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Samuel Brolia"
      user-mail-address "samuel_brolia@msn.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.


(setq doom-font (font-spec :family "Fira Code" :size 12))
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; (setq doom-font (font-spec :family "JetBrainsMono" :size 12 :weight 'light)
;;       doom-variable-pitch-font (font-spec :family "Noto Serif" :size 13)
;;       ivy-posframe-font (font-spec :family "JetBrainsMono" :size 15))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories  to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(setq auto-save-default t
      make-backup-files t)

(setq confirm-kill-emacs nil)

(setq-default
 delete-by-moving-to-trash t                      ; Delete files to trash
 window-combination-resize t                      ; take new window space from all other windows (not just current)
 x-stretch-cursor t)                              ; Stretch cursor to the glyph width

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      truncate-string-ellipsis "…"                ; Unicode ellispis are nicer than "...", and also save /precious/ space
      password-cache-expiry nil                   ; I can trust my computers ... can't I?
      scroll-preserve-screen-position 'always     ; Don't have `point' jump around
      scroll-margin 1)                            ; It's nice to maintain a little margin

(display-time-mode 1)                             ; Enable time in the mode-line

;; (unless (string-match-p "^Power N/A" (battery))   ; On laptops...
(display-battery-mode 1)                       ; it's nice to know how much power you have

(global-subword-mode 1)                           ; Iterate through CamelCase words

(setq evil-vsplit-window-right t
      evil-split-window-below t)


(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (+ivy/switch-buffer))

(setq +ivy-buffer-preview t)

(map! :map evil-window-map
      ;; navigation
      "<left>"     #'evil-window-left
      "<down>"     #'evil-window-down
      "<up>"       #'evil-window-up
      "<right>"    #'evil-window-right)
      ;; Swapping windows


(setq-default major-mode 'org-mode)


;; (plist-put! +ligatures-extra-symbols
;;      :comment       "💬")
;;   ;; org
;;   :name          "»"
;;   :src_block     "»"
;;   :src_block_end "«"
;;   :quote         "“"
;;   :quote_end     "”"
;;   ;; Functional
;;   :lambda        "λ"
;;   :def           "ƒ"
;;   :composition   "∘"
;;   :map           "↦"
;;   ;; Types
;;   :null          "∅"
;;   :true          "𝕋"
;;   :false         "𝔽"
;;   :int           "ℤ"
;;   :float         "ℝ"
;;   :str           "𝕊"
;;   :bool          "𝔹"
;;   :list          "𝕃"
;;   ;; Flow
;;   :not           "￢"
;;   :in            "∈"
;;   :not-in        "∉"
;;   :and           "∧"
;;   :or            "∨"
;;   :for           "∀"
;;   :some          "∃"
;;   :return        "⟼"
;;   :yield         "⟻"
;;   ;; Other
;;   :union         "⋃"
;;   :intersect     "∩"
;;   :diff          "∖"
;;   :tuple         "⨂"
;;   :pipe          "" ;; FIXME: find a non-private char
;;   :dot           "•")  ;

(after! rustic ; in this case the major mode and package named the same thing
  (set-ligatures! 'rustic-mode
    :def "fn" ; function keyword
    :true "true" :false "false"
    :int "i32" :str "string" :float "f32" :bool "bool"
    :for "for"
    :null "None" :some "Some"
    :return "return"))

(after! typescript-mode ; in this case the major mode and package named the same thing
  (set-ligatures! 'typescript-mode
    :true "true" :false "false" :not "!" :not "not"
    :int "number" :str "string" :bool "boolean"
    :for "for" :in "of"
    :null "None" :some "Some"
    :return "return"))

(mac-auto-operator-composition-mode)
