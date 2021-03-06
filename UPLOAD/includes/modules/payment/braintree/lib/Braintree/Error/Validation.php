<?php

namespace Braintree\Error;

use Braintree\Util;

/**
 * error object returned as part of a validation error collection
 * provides read-only access to $attribute, $code, and $message
 *
 * <b>== More information ==</b>
 *
 * // phpcs:ignore Generic.Files.LineLength
 * For more detailed information on Validation errors, see {@link https://developers.braintreepayments.com/reference/general/validation-errors/overview/php https://developers.braintreepayments.com/reference/general/validation-errors/overview/php}
 *
 * @package    Braintree
 * @subpackage Error
 *
 * @property-read string $attribute
 * @property-read string $code
 * @property-read string $message
 */
class Validation
{
    private $_attribute;
    private $_code;
    private $_message;

    /**
     * @ignore
     * @param array $attributes
     */
    public function __construct($attributes)
    {
        $this->_initializeFromArray($attributes);
    }
    /**
     * initializes instance properties from the keys/values of an array
     * @ignore
     * @access protected
     * @param array $attributes array of properties to set - single level
     * @return void
     */
    private function _initializeFromArray($attributes)
    {
        foreach ($attributes as $name => $value) {
            $varName = "_$name";
            $this->$varName = Util::delimiterToCamelCase($value, '_');
        }
    }

    /**
     *
     * @ignore
     */
    public function __get($name)
    {
        $varName = "_$name";
        return isset($this->$varName) ? $this->$varName : null;
    }
}
