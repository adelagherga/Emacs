
;; ――――――――――――――――――――――――― Set up 'package' ―――――――――――――――――――――――――

(require 'package)

;; Initialize package sources
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Load and activate Emacs packages
(package-initialize)

;; Install 'use-package' if it is not installed
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

;; ――――――――――――――――――――――― Use better defaults ――――――――――――――――――――――

(setq-default
 ;; Don't use the compiled code if its the older package
 load-prefer-newer t

 ;; Do not show the startup message
 inhibit-startup-message t

 ;; Do not put 'customize' config in init.el; give it another file
 custom-file "~/.emacs.d/custom-file.el"

 ;; Use my name in the frame title :)
 frame-title-format (format "Adela's Emacs")

 ;; Do not create lockfiles
 create-lockfiles nil

 ;; Emacs can automatically create backup files. This tells Emacs to put all
 ;; backups in ~/.emacs.d/backups
 backup-directory-alist `(("." . ,(concat user-emacs-directory "backups")))

 ;; Do not autosave
 auto-save-default nil

 ;; Allow commands to be run on mininuffers
 enable-recursive-minibuffers t)

;; Change all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)

;; 'C-x o' is a 2 step key binding. 'M-o' is much easier
(global-set-key (kbd "M-o") 'other-window)

;; Delete whitespace just when a file is saved
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Do not use hard tabs
indent-tabs-mode nil

;; Disable column number in mode line
(column-number-mode t)

;; Display line numbers on the left-hand side
;; (global-linum-mode t) ;; this one used to shift the UI constantly
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
		shell-mode-hook
		term-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


;; Automatically update buffers if file content on the disk has changed
(global-auto-revert-mode t)

;; Load 'customize' config file
(load custom-file 'noerror)

;; Enable transparent title bar on macOS
(when (memq window-system '(mac ns))
 (add-to-list 'default-frame-alist '(ns-appearance . dark)) ;; {light, dark}
 (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t)))

;; Full screen frame at startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq line-move-visual nil)

(use-package all-the-icons)

;; ――――――――――――――――― Disable unnecessary UI elements ――――――――――――――――-

(progn
  ;; Do not show menu bar
  (menu-bar-mode -1)

  ;; Disable tooltips
;;  (tooltip-mode -1)

  ;; Do not show tool bar
  (when (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))

  ;; Do not show scroll bar
  (when (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

  ;; Highlight line on point
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

;; Hide minor modes from menu bar
(use-package minions
  :config (minions-mode 1))

(use-package ivy
  :bind ("C-s" . swiper)
  :init (ivy-mode 1) ;; Turn on ivy by default
  :config
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (setq ivy-count-format "(%d/%d) ")) ;; Change format of the number of results

;; Descriptions of M-x functions
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x) ;; bind M-x to counsel-M-x to get ivy-rich descriptions
	 ("C-x C-f" . counsel-find-file)) ;; use counsel find file instead of usual
  :config
  (setq ivy-initial-inputs-alist nil)) ;; Don't start searches with ^

;; displays key bindings
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.5)) ;; time delay for it to show up

;; better help info in C-h f, etc;; not sure about this one
(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; might need to function with evil mode - use with magit (later)
;(use-package general
;  :config
;  (general-create-definer rune/leader-keys
;			  :keymaps '(normal insert visual emacs)
;			  :prefix "SPC"
;			  :global-prefix "C-SPC")
;
;  (rune/leader-keys
;   "t"  '(:ignore t :which-key "toggles")
;   "tt" '(counsel-load-theme :which-key "choose theme")))

;; ――――――――――― Additional packages and their configurations ―――――――――――

;; AucTeX configuration

;; Add working tex distribution to PATH for AucTeX
(setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin"))
(setq exec-path (append exec-path '("/Library/TeX/texbin")))

(setq TeX-parse-self t) ;; Enable parse on load
(setq TeX-auto-save t) ;; Enable parse on save
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)

;; Use Skim as viewer, enable source <-> PDF sync
;; Make latexmk available via C-c C-c
;; Note: SyncTeX is setup via ~/.latexmkrc (see below)
(add-hook 'LaTeX-mode-hook (lambda ()
 (push
   '("latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
     :help "Run latexmk on file")
   TeX-command-list)))
(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))

;; Use Skim as default PDF viewer
;; Skim's displayline is used for forward search (from .tex to .pdf)
;; option -b highlights the current line; option -g opens Skim in the background
(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
      '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))
(server-start)

;; Org mode configuration

(defun adela/org-mode-setup ()
  (org-indent-mode))

(defun adela/org-font-setup ()
;; Replace list hyphen with dot
  ;; (font-lock-add-keywords 'org-mode
                          ;; '(("^ *\\([-]\\) "
                             ;; (0 (prog1 () (compose-region (match-beginning 1)
							  ;; (match-end 1) "•"))))))

;; Set faces for heading levels
(with-eval-after-load 'org-faces
  (dolist (face '((org-level-1 . 1.2)
		  (org-level-2 . 1.1)
		  (org-level-3 . 1.05)
		  (org-level-4 . 1.0)
		  (org-level-5 . 1.1)
		  (org-level-6 . 1.1)
		  (org-level-7 . 1.1)
		  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))))

(use-package org
  :hook (org-mode . adela/org-mode-setup)
  :config
  (setq org-ellipsis " ")
  (setq org-hide-emphasis-markers t)

  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (setq org-agenda-files
  	'("~/Dropbox/OrgFiles/Tasks.org"))

  (setq org-refile-targets
    '(("Archive.org" :maxlevel . 1)
      ("Tasks.org" :maxlevel . 1)))

  ;; Save Org buffers after refiling!
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  (setq org-todo-keywords
  	'((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
  	  (sequence "|" "WAIT(w)" "BACK(b)")))

  ;; TODO: org-todo-keyword-faces
  (setq org-todo-keyword-faces
  	'(("NEXT" . (:foreground "orange red" :weight bold))
  	  ("WAIT" . (:foreground "HotPink2" :weight bold))
  	  ("BACK" . (:foreground "MediumPurple3" :weight bold))))

  ;; Configure common tags
  (setq org-tag-alist
  	'((:startgroup) ; Put mutually exclusive tags here
  	  (:endgroup)
  	  ("@home" . ?H)
  	  ("@work" . ?W)
  	  ("batch" . ?b) ; do i need a batch tag?
  	  ("followup" . ?f)))
  ;; Control the distance of tags at the end of heading
  (setq org-tags-column 0)

  ;; Agendas
  (setq org-agenda-window-setup 'current-window)
  (setq org-agenda-span 'day)
  (setq org-agenda-start-with-log-mode t)
  (setq org-agenda-tags-column -90)

  (setq org-agenda-custom-commands
      `(("d" "Dashboard"
         ((agenda "" ((org-deadline-warning-days 7)))
          (tags-todo "+PRIORITY=\"A\""
                     ((org-agenda-overriding-header "High Priority")))
          (tags-todo "+followup" ((org-agenda-overriding-header "Needs Follow Up")))
          (todo "NEXT"
                ((org-agenda-overriding-header "Next Actions")))
          (todo "TODO"
                ((org-agenda-overriding-header "Unprocessed Inbox Tasks") ))))

        ("n" "Next Tasks"
         ((agenda "" ((org-deadline-warning-days 7)))
          (todo "NEXT"
                ((org-agenda-overriding-header "Next Tasks")))))

        ;; Low-effort next actions
        ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
         ((org-agenda-overriding-header "Low Effort Tasks")
          (org-agenda-max-todos 20)
          (org-agenda-files org-agenda-files)))))

  (setq org-capture-templates
  	`(("t" "Task" entry (file+olp "~/Dropbox/OrgFiles/Tasks.org" "Inbox")
           "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)

  	  ;; can use General Entry for meetings, courses, etc
  	  ;; can use Task Entry to take notes on a specific project part
  	  ;; journal for anything else (minor)

  	  ("j" "Journal Entries")
  	  ("je" "General Entry" entry
  	   (file+olp+datetree "~/Dropbox/OrgFiles/Journal.org")
  	   "\n* %<%I:%M %p> - %^{Title} \n\n%?\n\n"
  	   :tree-type month
  	   :clock-in :clock-resume
  	   :empty-lines 1)
  	  ("jt" "Task Entry" entry
  	   (file+olp+datetree "~/Dropbox/OrgFiles/Journal.org")
  	   "\n* %<%I:%M %p> - Task Notes: %a\n\n%?\n\n"
  	   :tree-type month
  	   :clock-in :clock-resume
  	   :empty-lines 1)
  	  ("jj" "Journal" entry
  	   (file+olp+datetree "~/Dropbox/OrgFiles/Journal.org")
  	   "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
  	   :tree-type month
  	   :clock-in :clock-resume
  	   :empty-lines 1)))
  (adela/org-font-setup))

;; Set global keyboard shortcut for org-capture
(global-set-key (kbd "C-c c") 'org-capture)

(use-package org-superstar
  :after org
  :hook (org-mode . org-superstar-mode)
  :custom
  (org-superstar-remove-leading-stars t)
  (org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●")))

;; ―――――――――――――――――――――― Programming languages ―――――――――――――――――――――

(require 'magma-mode)
(setq auto-mode-alist
(append '(("\\.mgm$\\|\\.m$" . magma-mode))
        auto-mode-alist))
(add-hook 'magma-mode-hook 'auto-insert)

(require 'multiple-cursors)

(elpy-enable)
(setq python-shell-interpreter "/anaconda3/bin/python"
      python-shell-interpreter-args "-i")
(with-eval-after-load 'python
  (defun python-shell-completion-native-try ()
    "Return non-nil if can trigger native completion."
    (let ((python-shell-completion-native-enable t)
          (python-shell-completion-native-output-timeout
           python-shell-completion-native-try-output-timeout))
      (python-shell-completion-native-get-completions
       (get-buffer-process (current-buffer))
       nil "_"))))

;; ―――――――――――――――――――――――――――――― Themes ――――――――――――――――――――――――――――――

(use-package doom-themes
  :init (load-theme 'doom-palenight t))
