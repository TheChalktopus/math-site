;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path.
(require 'package)
(setq package-user-dir (expand-file-name "~/Sites/math-site/.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)

;; Load the publishing system
(require 'ox-publish)

;; Customize the HTML output
;(setq org-html-validation-link nil            ;; Don't show validation link
;      org-html-head-include-scripts nil       ;; Use our own scripts
;      org-html-head-include-default-style nil ;; Use our own styles
;      org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />")

;; Define the publishing project
(setq org-publish-project-alist
      '(

  ("org-ak"
          ;; Path to your org files.
          :base-directory "~/Sites/math-site/org/"
          :base-extension "org"
	  :sitemap-filename "index.org"
	  :sitemap-title   "Index"

          ;; Path to your Jekyll project.
          :publishing-directory "~/Sites/math-site/docs/"
          :recursive t
          :publishing-function org-publish-org-to-html
          :headline-levels 4
          :html-extension "html"
          :body-only t ;; Only export section between <body> </body>
    )


    ("org-static-ak"
          :base-directory "~/Sites/math-site/org/"
          :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|php"
          :publishing-directory "~/Sites/math-site/"
          :recursive t
          :publishing-function org-publish-attachment)

    ("ak" :components ("org-ak" "org-static-ak"))

))
;; Generate the site output
(org-publish-all t)




(message "Build complete!")
