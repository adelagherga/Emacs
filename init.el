
;; ――――――――――――――――――――――――― Set up 'package' ―――――――――――――――――――――――――

(require 'package)

;; Add melpa to package archives.
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

;; Load and activate Emacs packages.
(package-initialize)

;; Install 'use-package' if it is not installed.
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

;; ――――――――――――――――――――――― Use better defaults ――――――――――――――――――――――

(setq-default
 ;; Don't use the compiled code if its the older package.
 load-prefer-newer t

 ;; Do not show the startup message.
 inhibit-startup-message t

 ;; Do not put 'customize' config in init.el; give it another file.
 custom-file "~/.emacs.d/custom-file.el"

 ;; Use my name in the frame title. :)
 frame-title-format (format "Adela's Emacs")

 ;; Do not create lockfiles.
 create-lockfiles nil

 ;; Emacs can automatically create backup files. This tells Emacs to put all
 ;; backups in ~/.emacs.d/backups
 backup-directory-alist `(("." . ,(concat user-emacs-directory "backups")))

 ;; Do not autosave.
 auto-save-default nil

 ;; Allow commands to be run on mininuffers.
 enable-recursive-minibuffers t)

;; Change all yes/no questions to y/n type.
(fset 'yes-or-no-p 'y-or-n-p)

;; 'C-x o' is a 2 step key binding. 'M-o' is much easier.
(global-set-key (kbd "M-o") 'other-window)

;; Delete whitespace just when a file is saved.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Do not use hard tabs.
indent-tabs-mode nil

;; Disable column number in mode line.
(column-number-mode t)

;; Display line numbers on the left-hand side.
(global-linum-mode t)

;; Automatically update buffers if file content on the disk has changed.
(global-auto-revert-mode t)

;; Load 'customize' config file.
(load custom-file 'noerror)

;; Enable transparent title bar on macOS.
(when (memq window-system '(mac ns))
 (add-to-list 'default-frame-alist '(ns-appearance . dark)) ;; {light, dark}
 (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t)))

;; ――――――――――――――――― Disable unnecessary UI elements ――――――――――――――――-

(progn
  ;; Do not show menu bar.
  (menu-bar-mode -1)

  ;; Do not show tool bar.
  (when (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))

  ;; Do not show scroll bar.
  (when (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

  ;; Highlight line on point.
  (global-hl-line-mode t))

;; ―――――――――――――― Added functionality (Generic usecases) ――――――――――――――

(yas-global-mode t)

(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))

(global-set-key (kbd "C-;") 'toggle-comment-on-line)

(defun comment-pretty ()
  "Inserts a comment with '―' (Unicode character: U+2015) on each side."
  (interactive)
  (let* ((comment (read-from-minibuffer "Comment: "))
         (comment-length (length comment))
         (current-column-pos (current-column))
         (space-on-each-side (/ (- fill-column
                                   current-column-pos
                                   comment-length
                                   (length comment-start)
                                   ;; Single space on each side of comment
                                   (if (> comment-length 0) 2 0)
                                   ;; Single space after comment syntax sting
                                   1)
                                2)))
    (if (< space-on-each-side 2)
        (message "Comment string is too big to fit in one line")
      (progn
        (insert comment-start)
        (when (equal comment-start ";")
          (insert comment-start))
        (insert " ")
        (dotimes (_ space-on-each-side) (insert "―"))
        (when (> comment-length 0) (insert " "))
        (insert comment)
        (when (> comment-length 0) (insert " "))
        (dotimes (_ (if (= (% comment-length 2) 0)
                        space-on-each-side
                      (- space-on-each-side 1)))
          (insert "―"))))))

(global-set-key (kbd "C-c ;") 'comment-pretty)

(ivy-mode 1) ;; Turn on ivy by default.
(global-set-key "\C-s" 'swiper) ;; Replace I-search with swiper.
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(setq ivy-count-format "(%d/%d) ") ;; Change format of the number of results.

;; ――――――――――― Additional packages and their configurations ―――――――――――

;; AucTeX configuration.

;; Add working tex distribution to PATH for AucTeX.
(setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin"))
(setq exec-path (append exec-path '("/Library/TeX/texbin")))

(setq TeX-parse-self t) ;; Enable parse on load.
(setq TeX-auto-save t) ;; Enable parse on save.
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)

;; Use Skim as viewer, enable source <-> PDF sync.
;; Make latexmk available via C-c C-c.
;; Note: SyncTeX is setup via ~/.latexmkrc (see below).
(add-hook 'LaTeX-mode-hook (lambda ()
 (push
   '("latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
     :help "Run latexmk on file")
   TeX-command-list)))
(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))

;; Use Skim as default PDF viewer.
;; Skim's displayline is used for forward search (from .tex to .pdf)
;; option -b highlights the current line; option -g opens Skim in the background
(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
    '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))




;; searching tools: Ivy, Counsel, Swiper, or Helm?
;; ―――――――――――――――――――――― Programming languages ―――――――――――――――――――――

(require 'magma-mode)
(setq auto-mode-alist
(append '(("\\.mgm$\\|\\.m$" . magma-mode))
        auto-mode-alist))
(add-hook 'magma-mode-hook 'auto-insert)

;; ―――――――――――――――――――――――――――――― Themes ――――――――――――――――――――――――――――――

(load-theme 'solarized-dark t)
