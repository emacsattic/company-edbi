;;; company-edbi.el --- Edbi backend for company-mode

;; Copyright (C) 2014 by Malyshev Artem

;; Author: Malyshev Artem <proofit404@gmail.com>
;; URL: https://github.com/proofit404/company-edbi
;; Version: 0.1.0
;; Package-Requires: ((company "0.8.5") (edbi "0.1.3") (cl-lib "0.5.0"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Add `company-edbi' to allowed `company-mode' backends list
;;
;;     (add-to-list 'company-backends 'company-edbi)

;;; Code:

(require 'company)
(require 'cl-lib)
(require 'edbi)

;; edbi:ac-editor-table-candidates
;; edbi:ac-editor-column-candidates
;; edbi:ac-editor-type-candidates
;; edbi:ac-editor-keyword-candidates

(defun company-edbi-prefix ()
  "Grab prefix for `company-edbi' backend."
  (and (eq major-mode 'edbi:sql-mode)
       (not (company-in-string-or-comment))
       (or (company-grab-symbol-cons "\\." 1)
           'stop)))

;;;###autoload
(defun company-edbi (command &optional arg)
  "Edbi backend for company-mode.
See `company-backends' for more info about COMMAND and ARG."
  (interactive (list 'interactive))
  (cl-case command
    (interactive (company-begin-backend 'company-edbi))
    (prefix (company-edbi-prefix))
    (candidates nil)))

(add-hook 'edbi:dbview-update-hook 'edbi:ac-editor-word-candidate-update)

(provide 'company-edbi)

;;; company-edbi.el ends here
