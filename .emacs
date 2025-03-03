;; Basic UI Tweaks
(menu-bar-mode -1)    ;; Disable menu bar
(tool-bar-mode -1)    ;; Disable tool bar
(scroll-bar-mode -1)  ;; Disable scroll bar
(set-fringe-mode 10)  ;; Give some breathing room
(setq inhibit-startup-message t)  ;; Disable welcome screen

;; Line numbers and syntax highlighting
(global-display-line-numbers-mode 1)
(global-hl-line-mode 1)  ;; Highlight current line
(setq column-number-mode t)  ;; Show column numbers

;; Better backups
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))
