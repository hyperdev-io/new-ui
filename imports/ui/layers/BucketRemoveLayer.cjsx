React                 = require 'react'
{withState, compose}  = require 'recompose'
{ Button, CheckBox, Layer, Form, Header, Heading, Paragraph, FormFields, FormField, Footer, Icons } = require 'grommet'

withRiskChecked = withState 'riskChecked', 'setRiskChecked', false

module.exports = withRiskChecked ({hidden, selectedBucket, riskChecked, setRiskChecked, onClose, onSubmit}) ->
  _onSubmit = if riskChecked then (-> onSubmit selectedBucket) else null

  <Layer onClose={onClose} align='right' closer={true} hidden={hidden}>
   <Form>
    <Header pad={vertical: 'medium'}><Heading>Remove bucket</Heading></Header>
    <FormFields>
      <Paragraph size='large'>
        All data inside bucket <strong>{selectedBucket}</strong> will be removed. This operation is irreversible.
      </Paragraph>
      <Paragraph style={backgroundColor:'#faebcc', padding:'20px 10px'} size='large' align='center'>
        <strong>Do you really want to delete this bucket?</strong>
      </Paragraph>

      <CheckBox label='Yes, I understand the risks.'
        onChange={(evt) -> setRiskChecked evt.target.checked}
        checked={riskChecked}/>
    </FormFields>
    <Footer pad={vertical:'medium'} justify='between' align='center'>
      <Button icon={<Icons.Base.Trash />} onClick={_onSubmit} primary=true label='Remove' />
      <Button onClick={onClose} plain=true label='Cancel' />
    </Footer>
   </Form>
  </Layer>
